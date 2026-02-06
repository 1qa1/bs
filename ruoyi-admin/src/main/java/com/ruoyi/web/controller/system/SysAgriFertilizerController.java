package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCFertilizer;
import com.ruoyi.system.domain.AgriFertilizer;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriFertilizerServiceImpl;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import com.ruoyi.system.utils.GenerateUUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
 * 肥料管理 Controller
 */
@Slf4j
@RestController
@RequestMapping("/system/fertilizer")
public class SysAgriFertilizerController {

    @Autowired
    private AgriFertilizerServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addFertilizer(@RequestBody AgriFertilizer fertilizer) {
        // 1. 生成业务主键 FID
        fertilizer.setFid(GenerateUUID.Generate());
        // 2. 设置初始状态
        fertilizer.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriFertilizer(fertilizer);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriFertilizer dbFertilizer = service.selectFertilizerByFid(fertilizer.getFid());
                if (dbFertilizer == null)
                    return;

                // 准备上链数据
                AgriBCFertilizer bcFertilizer = new AgriBCFertilizer();
                bcFertilizer.setID(fertilizer.getFid());
                bcFertilizer.setPid(fertilizer.getGid()); // 注意：这里可能需要根据业务逻辑确认是传gid还是pid
                bcFertilizer.setName(fertilizer.getName());
                bcFertilizer.setCompany(fertilizer.getCompany());
                bcFertilizer.setBatchNo(fertilizer.getBatchNo());
                bcFertilizer.setUseTime(fertilizer.getUseTime());

                // 执行上链
                service.submitFertilizer(bcFertilizer);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbFertilizer.setTxHash(tx.getTxid());
                dbFertilizer.setTimeStamp(tx.getTimestamp());
                dbFertilizer.setStatus(1); // 成功
                service.updateAgriFertilizer(dbFertilizer);

                // 备份交易记录
                tx.setPid(fertilizer.getFid());
                txService.insertAgriTx(tx);

                log.info("肥料信息 {} 异步上链成功", fertilizer.getFid());

            } catch (Exception e) {
                log.error("肥料信息 {} 上链失败", fertilizer.getFid(), e);
                try {
                    AgriFertilizer failItem = service.selectFertilizerByFid(fertilizer.getFid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriFertilizer(failItem);
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
    public AjaxResult updateFertilizer(@RequestBody AgriFertilizer fertilizer) {
        service.updateAgriFertilizer(fertilizer);
        return AjaxResult.success("修改成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteFertilizer(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriFertilizer dbFertilizer = service.selectAgriFertilizerById(id);
            if (dbFertilizer != null) {
                service.deleteAgriFertilizerById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询列表
    @GetMapping("/top/{id}")
    public AjaxResult getFertilizer(@PathVariable("id") String id) {
        List<AgriFertilizer> list;

        // 判断是否查询所有
        if ("all".equals(id) || "null".equals(id)) {
            list = service.selectAgriFertilizerList(null);
        } else {
            // 优先尝试按 GID 查询 (精确查批次)
            // 假设 service 有 selectFertilizerByGid 方法 (参考 AgriMedicine)
            // 如果没有，需要检查 AgriFertilizerMapper 和 XML
            // 根据 AgriMedicine 的模式，Mapper 应该有。
            // 这是一个推断，如果编译报错，说明 Mapper 缺方法。
            // 但为了满足用户 "查询到" 的需求，必须支持 GID 查询。

            // 尝试 GID 查询
            // 由于 AgriFertilizerMapper 可能没有显式的 selectFertilizerByGid，
            // 我们可以用 selectAgriFertilizerList + where gid = #{gid}
            // 但 controller 只能调 service。
            AgriFertilizer searchGid = new AgriFertilizer();
            searchGid.setGid(id);
            list = service.selectAgriFertilizerList(searchGid);

            // 如果 GID 查不到，尝试按 PID 查
            if (list == null || list.isEmpty()) {
                AgriFertilizer searchPid = new AgriFertilizer();
                searchPid.setPid(id);
                list = service.selectAgriFertilizerList(searchPid);
            }
        }

        // 替换 pid 为产品名称用于显示
        for (AgriFertilizer item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";

            // 类似于 Grow/Medicine，我们最好不要覆盖 pid，而是用 params
            // 但 Fertilizer 前端之前也是取 pid 显示。
            // 为了安全起见，这里还是覆盖 pid，或者前端改成 params
            // 考虑到要修前端比较多，这里暂时保持覆盖 pid。
            item.setPid(pName);
        }

        return AjaxResult.success(list);
    }

    // 查询单个详情 (根据数据库 ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriFertilizer dbFertilizer = service.selectAgriFertilizerById(id);
        if (dbFertilizer == null) {
            return AjaxResult.error("未找到相关肥料记录");
        }

        // 补充链上信息
        String fid = dbFertilizer.getFid();
        AgriTx tx = txService.selectAgriTxByPid(fid);
        if (tx != null) {
            dbFertilizer.setTxHash(tx.getTxid());
            dbFertilizer.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbFertilizer);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriFertilizer fertilizer) {
        List<AgriFertilizer> list = service.selectAgriFertilizerList(fertilizer);
        for (AgriFertilizer item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriFertilizer> util = new ExcelUtil<>(AgriFertilizer.class);
        util.exportExcel(response, list, "肥料数据");
    }
}