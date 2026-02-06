package com.ruoyi.web.controller.system;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCCheck;
import com.ruoyi.system.domain.AgriCheck;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriCheckServiceImpl;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import com.ruoyi.system.utils.GenerateUUID;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import org.hyperledger.fabric.client.*;

/**
 * 自我检查 controller
 */
@Slf4j
@RestController
@RequestMapping("/system/check/")
public class SysAgriCheckController {

    @Autowired
    private AgriCheckServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addCheck(@RequestBody AgriCheck check) {
        // 1. 生成业务主键 CID
        check.setCid(GenerateUUID.Generate());
        // 2. 设置初始状态
        check.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriCheck(check);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriCheck dbCheck = service.selectCheckByCid(check.getCid());
                if (dbCheck == null)
                    return;

                // 准备上链数据
                AgriBCCheck bcCheck = new AgriBCCheck();
                bcCheck.setID(check.getCid());
                bcCheck.setPid(check.getGid()); // 注意：通常将 gid 传给链上的 Pid 字段，或根据链码实际结构调整
                bcCheck.setProjName(check.getProjName());
                bcCheck.setTypes(check.getTypes());
                bcCheck.setResult(check.getResult());
                bcCheck.setUploadsUrl(check.getUploadsUrl());

                // 执行上链
                service.submitCheck(bcCheck);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbCheck.setTxHash(tx.getTxid());
                dbCheck.setTimeStamp(tx.getTimestamp());
                dbCheck.setStatus(1); // 成功
                service.updateAgriCheck(dbCheck);

                // 备份交易记录
                tx.setPid(check.getCid());
                txService.insertAgriTx(tx);

                log.info("检测信息 {} 异步上链成功", check.getCid());

            } catch (Exception e) {
                log.error("检测信息 {} 上链失败", check.getCid(), e);
                try {
                    AgriCheck failItem = service.selectCheckByCid(check.getCid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriCheck(failItem);
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
    public AjaxResult updateCheck(@RequestBody AgriCheck check) {
        service.updateAgriCheck(check);
        return AjaxResult.success("更新成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteCheck(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriCheck dbCheck = service.selectAgriCheckById(id);
            if (dbCheck != null) {
                service.deleteAgriCheckById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询
    @GetMapping("/top/{id}")
    public AjaxResult getCheck(@PathVariable("id") String pid) throws GatewayException {
        // 查询所有的cid 根据pid
        List<AgriCheck> agriChecks = service.selectCheckByPid(pid);
        List<AgriBCCheck> results = new ArrayList<>();
        // 注意：如果 pid 是 'all'，selectProductByPid(pid) 可能会报错或返回 null，需防御
        // 但原有逻辑似乎假设 pid 有效？
        // 如果 pid="all"，service.selectCheckByPid("all") 会返回所有吗？
        // 上面代码 agriChecks = service.selectCheckByPid(pid);
        // 如果 pid 是 "all", mapper 需要处理。假设它能返回列表。

        for (AgriCheck check : agriChecks) {
            AgriBCCheck bcCheck = service.queryCheck(check.getCid());
            if (!Objects.isNull(bcCheck)) {
                // 原逻辑：bcCheck.setPid(name); 覆盖了 UUID
                // 新逻辑：保留 UUID，将名称放入 params
                String name = "未知产品";
                if (check.getPid() != null) {
                    com.ruoyi.system.domain.AgriProduct p = productService.selectProductByPid(check.getPid());
                    if (p != null) {
                        name = p.getName();
                    }
                }

                if (bcCheck.getParams() == null) {
                    bcCheck.setParams(new java.util.HashMap<>());
                }
                bcCheck.getParams().put("productName", name);

                AgriTx tx = txService.selectAgriTxByPid(bcCheck.getID());
                if (tx != null) {
                    bcCheck.setTxHash(tx.getTxid());
                    bcCheck.setTimeStamp(tx.getTimestamp());
                }
                results.add(bcCheck);
            } else {
                service.deleteAgriCheckById(check.getId());
            }
        }
        return AjaxResult.success(results);
    }

    // 查询单个信息
    @GetMapping("/{cid}")
    public AjaxResult getInfo(@PathVariable("cid") String cid) throws GatewayException {
        AgriCheck dbCheck = service.selectCheckByCid(cid);
        String pid = dbCheck.getPid();
        AgriBCCheck bcCheck = service.queryCheck(cid);

        String name = "未知产品";
        if (pid != null) {
            com.ruoyi.system.domain.AgriProduct p = productService.selectProductByPid(pid);
            if (p != null) {
                name = p.getName();
            }
        }

        if (bcCheck.getParams() == null) {
            bcCheck.setParams(new java.util.HashMap<>());
        }
        bcCheck.getParams().put("productName", name);

        AgriTx tx = txService.selectAgriTxByPid(cid);
        if (tx != null) {
            bcCheck.setTxHash(tx.getTxid());
            bcCheck.setTimeStamp(tx.getTimestamp());
        }
        return AjaxResult.success(bcCheck);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriCheck check) {
        List<AgriCheck> list = service.selectAgriCheckList(check);
        for (AgriCheck item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriCheck> util = new ExcelUtil<>(AgriCheck.class);
        util.exportExcel(response, list, "自行检查数据");
    }

    @PostMapping("/uploads")
    public AjaxResult saveImage(@RequestParam("file") MultipartFile file) throws IOException {
        if (!file.isEmpty()) {
            String avator = FileUploadUtils.upload(RuoYiConfig.getAvatarPath(), file);
            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", avator);
            return ajax;
        } else {
            return AjaxResult.error("图片上传失败，请联系管理员解决");
        }
    }
}