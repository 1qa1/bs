package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.service.impl.AgriGrowServiceImpl;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import com.ruoyi.system.utils.GenerateUUID;
import lombok.extern.slf4j.Slf4j;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;

/**
 * 种植情况 controller
 *
 **/
@Slf4j
@RestController
@RequestMapping("/system/grow")
public class SysAgriGrowController {

    @Autowired
    private AgriGrowServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addGrow(@RequestBody AgriGrow grow) {
        // 1. 生成业务主键 GID
        grow.setGid(GenerateUUID.Generate());

        // 2. 设置初始状态为 0 (处理中)
        grow.setStatus(0);

        // 3. 先存入 MySQL
        service.insertAgriGrow(grow);

        // 4. 异步处理上链
        CompletableFuture.runAsync(() -> {
            try {
                // 【新增】稍微等待一下，确保主线程事务提交（防止极快情况下的竞态条件）
                Thread.sleep(200);
                // 【新增】重新从数据库获取对象，确保 ID 存在且数据最新
                AgriGrow dbGrow = service.selectGrowByGid(grow.getGid());
                if (dbGrow == null) {
                    log.error("异步上链中止：未找到GID为 {} 的记录", grow.getGid());
                    return;
                }
                // --- 准备上链数据 ---
                AgriBCGrow bcGrow = new AgriBCGrow();
                bcGrow.setID(grow.getGid());
                bcGrow.setPid(grow.getPid());
                // 假设 AgriBCGrow 有这些字段的 setter，根据业务逻辑映射
                bcGrow.setPlantTime(grow.getPlantTime());
                bcGrow.setReapTime(grow.getReapTime());

                // --- 执行上链 ---
                service.submitGrow(bcGrow);

                // --- 获取交易信息 ---
                AgriTx tx = service.queryTxHash();

                // --- 上链成功，回写数据库 ---
                grow.setTxHash(tx.getTxid());
                grow.setTimeStamp(tx.getTimestamp());
                grow.setStatus(1); // 成功
                service.updateAgriGrow(grow);

                // --- 备份交易记录 ---
                tx.setPid(grow.getGid());
                txService.insertAgriTx(tx);

                log.info("种植信息 {} 异步上链成功", grow.getGid());

            } catch (Exception e) {
                log.error("种植信息 {} 异步上链失败", grow.getGid(), e);
                // 失败处理
                try {
                    // 再次尝试获取对象更新状态
                    AgriGrow failGrow = service.selectGrowByGid(grow.getGid());
                    if (failGrow != null) {
                        failGrow.setStatus(2); // 失败
                        service.updateAgriGrow(failGrow);
                    }
                } catch (Exception ex) {
                    log.error("更新失败状态异常", ex);
                }
            }
        });

        return AjaxResult.success("新增成功，数据正在后台上链...");
    }

    @PutMapping("/")
    public AjaxResult updateGrow(@RequestBody AgriGrow grow) {
        // 1. 先更新数据库
        service.updateAgriGrow(grow);

        // 2. 异步处理链上更新
        CompletableFuture.runAsync(() -> {
            try {
                AgriBCGrow bcGrow = new AgriBCGrow();
                bcGrow.setID(grow.getGid());
                bcGrow.setPid(grow.getPid());
                bcGrow.setPlantTime(grow.getPlantTime());
                bcGrow.setReapTime(grow.getReapTime());

                // 执行链上更新
                service.updateGrow(bcGrow);

                // 更新交易记录
                AgriTx tx = service.queryTxHash();
                tx.setPid(grow.getGid());

                // 更新数据库状态
                grow.setTxHash(tx.getTxid());
                grow.setTimeStamp(tx.getTimestamp());
                grow.setStatus(1);
                service.updateAgriGrow(grow);

                txService.updateAgriTx(tx);
                log.info("种植信息 {} 更新上链成功", grow.getGid());

            } catch (Exception e) {
                log.error("种植信息 {} 更新上链失败", grow.getGid(), e);
            }
        });

        return AjaxResult.success("更新提交成功，正在同步至区块链...");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteGrow(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            // 1. 查询数据库对象
            AgriGrow dbGrow = service.selectAgriGrowById(id);
            if (dbGrow != null) {
                String gid = dbGrow.getGid();

                // 2. 删除数据库记录
                service.deleteAgriGrowById(id);

                // 3. 异步删除链上数据
                if (gid != null && !gid.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        try {
                            service.deleteGrow(gid);
                            txService.deleteAgriTxByPid(gid);
                            log.info("GID {} 链上数据删除成功", gid);
                        } catch (Exception e) {
                            log.error("GID {} 链上数据删除失败", gid, e);
                        }
                    });
                }
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询
    @GetMapping("/top/{id}")
    public AjaxResult getGrow(@PathVariable("id") String pid) {
        List<AgriGrow> agriGrows;

        // 1. 判断是否查询所有
        if ("all".equals(pid) || "null".equals(pid)) {
            agriGrows = service.selectAgriGrowList(null);
        } else {
            // 查询指定产品的记录
            AgriProduct product = productService.selectProductByPid(pid);
            if (product == null) {
                return AjaxResult.success(new ArrayList<>());
            }
            agriGrows = service.selectGrowByPid(pid);
        }

        // 2. 直接返回数据库中的数据，不再去链上逐个查询
        // 这样既能显示状态为 0 (上链中) 的数据，也不会误删数据
        for (AgriGrow grow : agriGrows) {
            // 获取产品名称用于显示
            // 注意：不要覆盖 pid (UUID)，而是放入 params 中供前端显示
            AgriProduct p = productService.selectProductByPid(grow.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";

            if (grow.getParams() == null) {
                grow.setParams(new java.util.HashMap<>());
            }
            grow.getParams().put("productName", pName);
        }

        return AjaxResult.success(agriGrows);
    }

    //
    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriGrow grow) {
        String pid = grow.getPid();
        List<AgriGrow> agriGrows = service.selectGrowByPid(pid);

        AgriProduct product = productService.selectProductByPid(pid);
        String name = (product != null) ? product.getName() : "未知产品";

        for (AgriGrow item : agriGrows) {
            // 导出时同理
            if (item.getParams() == null) {
                item.setParams(new java.util.HashMap<>());
            }
            item.getParams().put("productName", name);
        }

        // 注意：这里导出的是 AgriGrow 类，Excel注解需要调整映射字段吗？
        // 如果 Excel 注解绑定的是 pid，那导出的就是 UUID 了。
        // 为了保持导出产品名，这里暂时只能覆盖 pid，或者修改 Excel 注解。
        // 考虑到兼容性，导出功能这里暂时保持覆盖 pid 的逻辑，或者用户没特别要求导出，先不乱动。
        // 为了稳妥，导出时还是覆盖吧，毕竟 Excel 只有展示用。
        for (AgriGrow item : agriGrows) {
            item.setPid(name);
        }

        ExcelUtil<AgriGrow> util = new ExcelUtil<>(AgriGrow.class);
        util.exportExcel(response, agriGrows, "种植数据");
    }

    // 查询单个信息 根据gid
    @GetMapping("/{id}")
    /*
     * public AjaxResult getInfo(@PathVariable("id") String gid) throws
     * GatewayException {
     * AgriGrow dbGrow = service.selectGrowByGid(gid);
     * if (dbGrow == null) {
     * return AjaxResult.error("未找到相关种植记录");
     * }
     * 
     * // 如果需要补充链上的 Hash 和 TimeStamp (虽然数据库里也有)
     * AgriTx tx = txService.selectAgriTxByPid(gid);
     * if (tx != null) {
     * dbGrow.setTxHash(tx.getTxid());
     * dbGrow.setTimeStamp(tx.getTimestamp());
     * }
     * 
     * return AjaxResult.success(dbGrow);
     * }
     */
    public AjaxResult getInfo(@PathVariable("id") Long id) { // 1. 参数类型改为 Long id
        // 2. 使用 selectAgriGrowById 查询数据库 ID
        AgriGrow dbGrow = service.selectAgriGrowById(id);

        if (dbGrow == null) {
            return AjaxResult.error("未找到相关种植记录");
        }

        // 3. 获取 gid 用于查询关联的交易信息
        String gid = dbGrow.getGid();

        // 4. 补充链上信息 (保持原有逻辑)
        AgriTx tx = txService.selectAgriTxByPid(gid);
        if (tx != null) {
            dbGrow.setTxHash(tx.getTxid());
            dbGrow.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbGrow);
    }
    /*
     * public AjaxResult getInfo( @PathVariable("id") String gid) throws
     * GatewayException {
     * AgriGrow dbGrow = service.selectGrowByGid(gid);
     * if (dbGrow == null) {
     * return AjaxResult.error("未找到相关种植记录");
     * }
     * String pid = dbGrow.getPid();
     * AgriBCGrow grow = service.queryGrow(gid);
     * 
     *//*
        * String name = productService.selectProductByPid(pid).getName();
        * grow.setPid(name);
        * AgriTx tx = txService.selectAgriTxByPid(gid);
        * grow.setPid(name);
        * grow.setTxHash(tx.getTxid());
        * grow.setTimeStamp(tx.getTimestamp());
        *//*
           * grow.setPid(pid);
           * 
           * AgriTx tx = txService.selectAgriTxByPid(gid);
           * if (tx != null) {
           * grow.setTxHash(tx.getTxid());
           * grow.setTimeStamp(tx.getTimestamp());
           * }
           * return AjaxResult.success(grow);
           * }
           */
}
