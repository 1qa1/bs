package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCSell;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriSell;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriSellServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import com.ruoyi.system.utils.GenerateUUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;

/**
 * 售卖信息 Controller
 */
@Slf4j
@RestController
@RequestMapping("/system/sell")
public class SysAgriSellController {

    @Autowired
    private AgriSellServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addSell(@RequestBody AgriSell sell) {
        // 1. 生成业务主键 SID
        sell.setSid(GenerateUUID.Generate());
        // 2. 设置初始状态
        sell.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriSell(sell);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriSell dbSell = service.selectSellBySid(sell.getSid());
                if (dbSell == null) return;

                // 准备上链数据
                AgriBCSell bcSell = new AgriBCSell();
                bcSell.setID(sell.getSid());
                bcSell.setPid(sell.getPid());
                bcSell.setArrivalTime(sell.getArrivalTime());
                bcSell.setAmount(sell.getAmount());
                bcSell.setCheckTime(sell.getCheckTime());
                bcSell.setCheckName(sell.getCheckName());
                bcSell.setCheckResult(sell.getCheckResult());
                bcSell.setTp(sell.getTp());

                // 执行上链
                service.submitSell(bcSell);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbSell.setTxHash(tx.getTxid());
                dbSell.setTimeStamp(tx.getTimestamp());
                dbSell.setStatus(1); // 成功
                service.updateAgriSell(dbSell);

                // 备份交易记录
                tx.setPid(sell.getSid());
                txService.insertAgriTx(tx);

                log.info("售卖信息 {} 异步上链成功", sell.getSid());

            } catch (Exception e) {
                log.error("售卖信息 {} 上链失败", sell.getSid(), e);
                try {
                    AgriSell failItem = service.selectSellBySid(sell.getSid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriSell(failItem);
                    }
                } catch (Exception ex) {
                    log.error("更新失败状态异常", ex);
                }
            }
        });

        return AjaxResult.success("新增成功，数据正在后台上链...");
    }

    // 修改
    @PutMapping("/")
    public AjaxResult updateSell(@RequestBody AgriSell sell) {
        service.updateAgriSell(sell);
        return AjaxResult.success("修改成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteSell(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriSell dbSell = service.selectAgriSellById(id);
            if (dbSell != null) {
                service.deleteAgriSellById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询列表
    @GetMapping("/top/{id}")
    public AjaxResult getSell(@PathVariable("id") String pid) {
        List<AgriSell> list;

        // 判断是否查询所有
        if ("all".equals(pid) || "null".equals(pid)) {
            list = service.selectAgriSellList(null);
        } else {
            AgriProduct product = productService.selectProductByPid(pid);
            if (product == null) {
                return AjaxResult.success(new ArrayList<>());
            }
            list = service.selectSellByPid(pid);
        }

        // 替换 pid 为产品名称用于显示
        for (AgriSell item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        return AjaxResult.success(list);
    }

    // 查询单个详情 (根据数据库 ID)
    /*@GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriSell dbSell = service.selectAgriSellById(id);
        if (dbSell == null) {
            return AjaxResult.error("未找到相关售卖记录");
        }

        // 补充链上信息
        String sid = dbSell.getSid();
        AgriTx tx = txService.selectAgriTxByPid(sid);
        if (tx != null) {
            dbSell.setTxHash(tx.getTxid());
            dbSell.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbSell);
    }*/
    // 查询单个详情 (根据数据库 ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriSell dbSell = service.selectAgriSellById(id);
        if (dbSell == null) {
            return AjaxResult.error("未找到相关售卖记录");
        }

        // --- 核心修改：增加读时校验 (Verify-on-Read) ---
        boolean isVerified = false;
        List<String> tamperedFields = new ArrayList<>();
        String verifyMsg = "数据未上链，无法校验";

        // 只有状态为“已上链” (status == 1) 才进行校验
        if (dbSell.getStatus() != null && dbSell.getStatus() == 1) {
            try {
                // 【核心步骤】从区块链获取“真实”数据
                // 使用 SID 作为链上的 Key
                // 假设 service 已经实现了 querySell 方法
                AgriBCSell bcSell = service.querySell(dbSell.getSid());

                if (bcSell != null) {
                    // 逐字段比对
                    // 比对关联产品ID
                    /*if (!Objects.equals(dbSell.getPid(), bcSell.getPid())) {
                        tamperedFields.add("关联产品ID(本地:" + dbSell.getPid() + " vs 链上:" + bcSell.getPid() + ")");
                    }*/
                    // 比对到达时间
                    if (!Objects.equals(dbSell.getArrivalTime(), bcSell.getArrivalTime())) {
                        tamperedFields.add("到达时间");
                    }
                    // 比对售卖数量
                    // 注意类型匹配，如果一个是String一个是Integer，需要转换
                    if (!Objects.equals(dbSell.getAmount(), bcSell.getAmount())) {
                        tamperedFields.add("售卖数量");
                    }
                    // 比对检验时间
                    if (!Objects.equals(dbSell.getCheckTime(), bcSell.getCheckTime())) {
                        tamperedFields.add("检验时间");
                    }
                    // 比对检验项目
                    if (!Objects.equals(dbSell.getCheckName(), bcSell.getCheckName())) {
                        tamperedFields.add("检验项目");
                    }
                    // 比对检验结果
                    if (!Objects.equals(dbSell.getCheckResult(), bcSell.getCheckResult())) {
                        tamperedFields.add("检验结果");
                    }
                    // 比对商品规格
                    if (!Objects.equals(dbSell.getTp(), bcSell.getTp())) {
                        tamperedFields.add("商品规格");
                    }

                    if (tamperedFields.isEmpty()) {
                        isVerified = true;
                        verifyMsg = "校验通过：数据真实有效";
                    } else {
                        verifyMsg = "警告：发现数据篡改！";
                        log.warn("数据篡改报警: ID={}, SID={}, 差异={}", id, dbSell.getSid(), tamperedFields);
                    }
                } else {
                    verifyMsg = "校验失败：链上未找到对应数据";
                }
            } catch (Exception e) {
                log.error("区块链连接异常，无法完成校验", e);
                verifyMsg = "校验中断：区块链网络连接超时";
            }
        }

        // 封装校验结果到 params
        if (dbSell.getParams() == null) {
            dbSell.setParams(new java.util.HashMap<>());
        }
        dbSell.getParams().put("isVerified", isVerified);
        dbSell.getParams().put("verifyMsg", verifyMsg);
        dbSell.getParams().put("tamperedFields", tamperedFields);

        // 补充链上信息
        String sid = dbSell.getSid();
        AgriTx tx = txService.selectAgriTxByPid(sid);
        if (tx != null) {
            dbSell.setTxHash(tx.getTxid());
            dbSell.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbSell);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriSell sell) {
        List<AgriSell> list = service.selectAgriSellList(sell);
        for (AgriSell item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriSell> util = new ExcelUtil<>(AgriSell.class);
        util.exportExcel(response, list, "售卖数据");
    }
}