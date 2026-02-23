package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCTransport;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTransport;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriTransportServiceImpl;
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
 * 运输信息 Controller
 */
@Slf4j
@RestController
@RequestMapping("/system/transport")
public class SysAgriTransportController {

    @Autowired
    private AgriTransportServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addTransport(@RequestBody AgriTransport transport) {
        // 1. 生成业务主键 TID
        transport.setTid(GenerateUUID.Generate());
        // 2. 设置初始状态
        transport.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriTransport(transport);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriTransport dbTransport = service.selectTransportByTid(transport.getTid());
                if (dbTransport == null) return;

                // 准备上链数据
                AgriBCTransport bcTransport = new AgriBCTransport();
                bcTransport.setID(transport.getTid());
                bcTransport.setPid(transport.getPid());
                bcTransport.setDriverName(transport.getDriverName());
                bcTransport.setPhone(transport.getPhone());
                bcTransport.setCarNumber(transport.getCarNumber());
                bcTransport.setProductAmount(transport.getProductAmount());
                bcTransport.setStartCity(transport.getStartCity());
                bcTransport.setTp(transport.getTp());
                bcTransport.setEndCity(transport.getEndCity());
                bcTransport.setStartTime(transport.getStartTime());

                // 执行上链
                service.submitTransport(bcTransport);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbTransport.setTxHash(tx.getTxid());
                dbTransport.setTimeStamp(tx.getTimestamp());
                dbTransport.setStatus(1); // 成功
                service.updateAgriTransport(dbTransport);

                // 备份交易记录
                tx.setPid(transport.getTid());
                txService.insertAgriTx(tx);

                log.info("运输信息 {} 异步上链成功", transport.getTid());

            } catch (Exception e) {
                log.error("运输信息 {} 上链失败", transport.getTid(), e);
                try {
                    AgriTransport failItem = service.selectTransportByTid(transport.getTid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriTransport(failItem);
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
    public AjaxResult updateTransport(@RequestBody AgriTransport transport) {
        service.updateAgriTransport(transport);
        return AjaxResult.success("修改成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteTransport(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriTransport dbTransport = service.selectAgriTransportById(id);
            if (dbTransport != null) {
                service.deleteAgriTransportById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询列表
    @GetMapping("/top/{id}")
    public AjaxResult getTransport(@PathVariable("id") String pid) {
        List<AgriTransport> list;

        // 判断是否查询所有
        if ("all".equals(pid) || "null".equals(pid)) {
            list = service.selectAgriTransportList(null);
        } else {
            AgriProduct product = productService.selectProductByPid(pid);
            if (product == null) {
                return AjaxResult.success(new ArrayList<>());
            }
            list = service.selectTransportByPid(pid);
        }

        // 替换 pid 为产品名称用于显示
        for (AgriTransport item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        return AjaxResult.success(list);
    }

    // 查询单个详情 (根据数据库 ID)
    /*@GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriTransport dbTransport = service.selectAgriTransportById(id);
        if (dbTransport == null) {
            return AjaxResult.error("未找到相关运输记录");
        }

        // 补充链上信息
        String tid = dbTransport.getTid();
        AgriTx tx = txService.selectAgriTxByPid(tid);
        if (tx != null) {
            dbTransport.setTxHash(tx.getTxid());
            dbTransport.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbTransport);
    }*/
    // 查询单个详情 (根据数据库 ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriTransport dbTransport = service.selectAgriTransportById(id);
        if (dbTransport == null) {
            return AjaxResult.error("未找到相关运输记录");
        }

        // --- 核心修改：增加读时校验 (Verify-on-Read) ---
        boolean isVerified = false;
        List<String> tamperedFields = new ArrayList<>();
        String verifyMsg = "数据未上链，无法校验";

        // 只有状态为“已上链” (status == 1) 才进行校验
        if (dbTransport.getStatus() != null && dbTransport.getStatus() == 1) {
            try {
                // 【核心步骤】从区块链获取“真实”数据
                // 使用 TID 作为链上的 Key
                // 假设 service 已经实现了 queryTransport 方法
                AgriBCTransport bcTransport = service.queryTransport(dbTransport.getTid());

                if (bcTransport != null) {
                    // 逐字段比对
                    if (!Objects.equals(dbTransport.getDriverName(), bcTransport.getDriverName())) {
                        tamperedFields.add("司机姓名");
                    }
                    if (!Objects.equals(dbTransport.getPhone(), bcTransport.getPhone())) {
                        tamperedFields.add("电话号码");
                    }
                    if (!Objects.equals(dbTransport.getCarNumber(), bcTransport.getCarNumber())) {
                        tamperedFields.add("车牌号");
                    }
                    // 注意类型匹配，如果一个是String一个是Integer，需要转换
                    if (!Objects.equals(dbTransport.getProductAmount(), bcTransport.getProductAmount())) {
                        tamperedFields.add("商品数量");
                    }
                    if (!Objects.equals(dbTransport.getStartCity(), bcTransport.getStartCity())) {
                        tamperedFields.add("出发地");
                    }
                    if (!Objects.equals(dbTransport.getEndCity(), bcTransport.getEndCity())) {
                        tamperedFields.add("目的地");
                    }
                    if (!Objects.equals(dbTransport.getStartTime(), bcTransport.getStartTime())) {
                        tamperedFields.add("开始时间");
                    }
                    // 比对关联产品ID
                    /*if (!Objects.equals(dbTransport.getPid(), bcTransport.getPid())) {
                        tamperedFields.add("关联产品ID(本地:" + dbTransport.getPid() + " vs 链上:" + bcTransport.getPid() + ")");
                    }*/

                    if (tamperedFields.isEmpty()) {
                        isVerified = true;
                        verifyMsg = "校验通过：数据真实有效";
                    } else {
                        verifyMsg = "警告：发现数据篡改！";
                        log.warn("数据篡改报警: ID={}, TID={}, 差异={}", id, dbTransport.getTid(), tamperedFields);
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
        if (dbTransport.getParams() == null) {
            dbTransport.setParams(new java.util.HashMap<>());
        }
        dbTransport.getParams().put("isVerified", isVerified);
        dbTransport.getParams().put("verifyMsg", verifyMsg);
        dbTransport.getParams().put("tamperedFields", tamperedFields);

        // 补充链上信息
        String tid = dbTransport.getTid();
        AgriTx tx = txService.selectAgriTxByPid(tid);
        if (tx != null) {
            dbTransport.setTxHash(tx.getTxid());
            dbTransport.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbTransport);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriTransport transport) {
        List<AgriTransport> list = service.selectAgriTransportList(transport);
        for (AgriTransport item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriTransport> util = new ExcelUtil<>(AgriTransport.class);
        util.exportExcel(response, list, "运输数据");
    }
}