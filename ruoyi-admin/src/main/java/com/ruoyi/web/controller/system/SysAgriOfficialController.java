package com.ruoyi.web.controller.system;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCOfficialCheck;
import com.ruoyi.system.domain.AgriOfficial;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriOfficialServiceImpl;
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
import java.util.concurrent.CompletableFuture;

/**
 * 官方检查 controller
 */
@Slf4j
@RestController
@RequestMapping("/system/official/")
public class SysAgriOfficialController {
    @Autowired
    private AgriOfficialServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addOfficial(@RequestBody AgriOfficial official) {
        // 1. 生成业务主键 OID
        official.setOid(GenerateUUID.Generate());
        // 2. 设置初始状态
        official.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriOfficial(official);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriOfficial dbOfficial = service.selectOfficialByOid(official.getOid());
                if (dbOfficial == null) return;

                // 准备上链数据
                AgriBCOfficialCheck bcOfficial = new AgriBCOfficialCheck();
                bcOfficial.setID(official.getOid());
                bcOfficial.setPid(official.getPid());
                bcOfficial.setReportTime(official.getReportTime());
                bcOfficial.setReportResult(official.getReportResult());
                bcOfficial.setReportUploadsUrl(official.getReportUploadsUrl());

                // 执行上链
                service.submitOfficial(bcOfficial);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbOfficial.setTxHash(tx.getTxid());
                dbOfficial.setTimeStamp(tx.getTimestamp());
                dbOfficial.setStatus(1); // 成功
                service.updateAgriOfficial(dbOfficial);

                // 备份交易记录
                tx.setPid(official.getOid());
                txService.insertAgriTx(tx);

                log.info("官方检查信息 {} 异步上链成功", official.getOid());

            } catch (Exception e) {
                log.error("官方检查信息 {} 上链失败", official.getOid(), e);
                try {
                    AgriOfficial failItem = service.selectOfficialByOid(official.getOid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriOfficial(failItem);
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
    public AjaxResult updateOfficial(@RequestBody AgriOfficial official) {
        service.updateAgriOfficial(official);
        return AjaxResult.success("更新成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteOfficial(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriOfficial dbOfficial = service.selectAgriOfficialById(id);
            if (dbOfficial != null) {
                service.deleteAgriOfficialById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询列表
    @GetMapping("/top/{id}")
    public AjaxResult getOfficial(@PathVariable("id") String pid) {
        List<AgriOfficial> list;

        // 判断是否查询所有
        if ("all".equals(pid) || "null".equals(pid)) {
            list = service.selectAgriOfficialList(null);
        } else {
            AgriProduct product = productService.selectProductByPid(pid);
            if (product == null) {
                return AjaxResult.success(new ArrayList<>());
            }
            AgriOfficial queryParam = new AgriOfficial();
            queryParam.setPid(pid);
            list = service.selectAgriOfficialList(queryParam);
        }

        // 替换 pid 为产品名称用于显示
        for (AgriOfficial item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        return AjaxResult.success(list);
    }

    // 查询单个信息 (根据数据库 ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriOfficial dbOfficial = service.selectAgriOfficialById(id);
        if (dbOfficial == null) {
            return AjaxResult.error("未找到相关官方检查记录");
        }

        // 补充链上信息
        String oid = dbOfficial.getOid();
        AgriTx tx = txService.selectAgriTxByPid(oid);
        if (tx != null) {
            dbOfficial.setTxHash(tx.getTxid());
            dbOfficial.setTimeStamp(tx.getTimestamp());
        }
        return AjaxResult.success(dbOfficial);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriOfficial official) {
        List<AgriOfficial> list = service.selectAgriOfficialList(official);
        for (AgriOfficial item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriOfficial> util = new ExcelUtil<>(AgriOfficial.class);
        util.exportExcel(response, list, "官方检查数据");
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