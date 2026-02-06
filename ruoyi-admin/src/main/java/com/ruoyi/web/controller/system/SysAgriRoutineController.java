package com.ruoyi.web.controller.system;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.AgriBCRoutineCheck;
import com.ruoyi.system.domain.AgriRoutine;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriRoutineServiceImpl;
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
 * 日常检查 controller
 */
@Slf4j
@RestController
@RequestMapping("/system/routine/")
public class SysAgriRoutineController {

    @Autowired
    private AgriRoutineServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addRoutine(@RequestBody AgriRoutine routine) {
        // 1. 生成业务主键 RID
        routine.setRid(GenerateUUID.Generate());
        // 2. 设置初始状态
        routine.setStatus(0);
        // 3. 存入 MySQL
        service.insertAgriRoutine(routine);

        // 4. 异步上链
        CompletableFuture.runAsync(() -> {
            try {
                Thread.sleep(200);
                AgriRoutine dbRoutine = service.selectRoutineByRid(routine.getRid());
                if (dbRoutine == null) return;

                // 准备上链数据
                AgriBCRoutineCheck bcRoutine = new AgriBCRoutineCheck();
                bcRoutine.setID(routine.getRid());
                bcRoutine.setPid(routine.getPid());
                bcRoutine.setCheckName(routine.getCheckName());
                bcRoutine.setCheckTime(routine.getCheckTime());
                bcRoutine.setProblems(routine.getProblems());
                bcRoutine.setProposal(routine.getProposal());
                bcRoutine.setOrgMember(routine.getOrgMember());
                bcRoutine.setUploadsUrl(routine.getUploadsUrl());

                // 执行上链
                service.submitRoutineCheck(bcRoutine);

                // 获取交易信息
                AgriTx tx = service.queryTxHash();

                // 回写数据库
                dbRoutine.setTxHash(tx.getTxid());
                dbRoutine.setTimeStamp(tx.getTimestamp());
                dbRoutine.setStatus(1); // 成功
                service.updateAgriRoutine(dbRoutine);

                // 备份交易记录
                tx.setPid(routine.getRid());
                txService.insertAgriTx(tx);

                log.info("日常检查信息 {} 异步上链成功", routine.getRid());

            } catch (Exception e) {
                log.error("日常检查信息 {} 上链失败", routine.getRid(), e);
                try {
                    AgriRoutine failItem = service.selectRoutineByRid(routine.getRid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriRoutine(failItem);
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
    public AjaxResult updateRoutine(@RequestBody AgriRoutine routine) {
        service.updateAgriRoutine(routine);
        return AjaxResult.success("更新成功");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteRoutine(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            AgriRoutine dbRoutine = service.selectAgriRoutineById(id);
            if (dbRoutine != null) {
                service.deleteAgriRoutineById(id);
                // 异步删除链上数据...
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询列表
    @GetMapping("/top/{id}")
    public AjaxResult getRoutine(@PathVariable("id") String pid) {
        List<AgriRoutine> list;

        // 判断是否查询所有
        if ("all".equals(pid) || "null".equals(pid)) {
            list = service.selectAgriRoutineList(null);
        } else {
            AgriProduct product = productService.selectProductByPid(pid);
            if (product == null) {
                return AjaxResult.success(new ArrayList<>());
            }
            AgriRoutine queryParam = new AgriRoutine();
            queryParam.setPid(pid);
            list = service.selectAgriRoutineList(queryParam);
        }

        // 替换 pid 为产品名称用于显示
        for (AgriRoutine item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        return AjaxResult.success(list);
    }

    // 查询单个信息 (根据数据库 ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriRoutine dbRoutine = service.selectAgriRoutineById(id);
        if (dbRoutine == null) {
            return AjaxResult.error("未找到相关日常检查记录");
        }

        // 补充链上信息
        String rid = dbRoutine.getRid();
        AgriTx tx = txService.selectAgriTxByPid(rid);
        if (tx != null) {
            dbRoutine.setTxHash(tx.getTxid());
            dbRoutine.setTimeStamp(tx.getTimestamp());
        }
        return AjaxResult.success(dbRoutine);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriRoutine routine) {
        List<AgriRoutine> list = service.selectAgriRoutineList(routine);
        for (AgriRoutine item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }
        ExcelUtil<AgriRoutine> util = new ExcelUtil<>(AgriRoutine.class);
        util.exportExcel(response, list, "日常检查数据");
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