package com.ruoyi.web.controller.system;

import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
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
public class SysAgriCheckController extends BaseController {

    @Autowired
    private AgriCheckServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 查询自我检查列表 (支持分页和条件查询)
     * 供运输端筛选合格产品使用
     */
    @GetMapping("/list")
    public TableDataInfo list(AgriCheck agriCheck) {
        startPage(); // 开启分页
        List<AgriCheck> list = service.selectAgriCheckList(agriCheck);

        // 遍历列表，填充产品名称和种植地
        for (AgriCheck item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            if (p != null) {
                item.getParams().put("productName", p.getName());
                // 填充种植地，供运输端自动填写出发地
                item.getParams().put("plantCity", p.getPlantCity());
            } else {
                item.getParams().put("productName", "未知产品");
                item.getParams().put("plantCity", "");
            }
        }
        return getDataTable(list); // 返回分页数据
    }

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
                //bcCheck.setPid(check.getGid());
                bcCheck.setPid(check.getPid());
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
    public AjaxResult getCheck(@PathVariable("id") String pid) {
        List<AgriCheck> list;

        // 1. 根据 pid 从数据库查询 AgriCheck 列表 (这些对象包含 status 字段)
        if ("all".equals(pid) || "null".equals(pid) || pid == null) {
            list = service.selectAgriCheckList(null);
        } else {
            // 按产品 pid 筛选
            AgriCheck queryParam = new AgriCheck();
            queryParam.setPid(pid);
            list = service.selectAgriCheckList(queryParam);
        }

        // 2. 遍历列表，为每个对象填充前端需要的附加信息（如产品名称）
        for (AgriCheck item : list) {
            // 根据 item 中的 pid 查找产品名称
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";

            // 关键：将产品名称放入 BaseEntity 自带的 params Map 中
            // 这样既不破坏原有对象结构，又能传递额外信息
            item.getParams().put("productName", pName);
        }

        // 3. 返回包含了 status 和 productName 的数据库对象列表
        return AjaxResult.success(list);
    }

    // 查询单个信息
    @GetMapping("/{id}")
    /*public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriCheck dbCheck = service.selectAgriCheckById(id);
        if (dbCheck == null) {
            return AjaxResult.error("未找到相关检测记录");
        }

        // 补充链上信息
        String cid = dbCheck.getCid();
        AgriTx tx = txService.selectAgriTxByPid(cid);
        if (tx != null) {
            dbCheck.setTxHash(tx.getTxid());
            dbCheck.setTimeStamp(tx.getTimestamp());
        }
        return AjaxResult.success(dbCheck);
    }*/
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        // 1. 从 MySQL 读取原始数据
        AgriCheck dbCheck = service.selectAgriCheckById(id);
        if (dbCheck == null) {
            return AjaxResult.error("未找到相关检测记录");
        }

        // 2. 初始化校验状态
        boolean isVerified = false; // 默认为未校验/校验失败
        List<String> tamperedFields = new ArrayList<>();
        String verifyMsg = "数据未上链，无法校验";

        // 3. 只有状态为“已上链” (status == 1) 才进行校验
        if (dbCheck.getStatus() != null && dbCheck.getStatus() == 1) {
            try {
                // 【核心步骤】从区块链获取“真实”数据
                // 假设 service.queryCheck(cid) 已经实现了调用 Fabric SDK 的逻辑
                AgriBCCheck bcCheck = service.queryCheck(dbCheck.getCid());

                if (bcCheck != null) {
                    // 4. 逐字段比对
                    // 比对项目名称
                    if (!Objects.equals(dbCheck.getProjName(), bcCheck.getProjName())) {
                        tamperedFields.add("项目名称(本地:" + dbCheck.getProjName() + " vs 链上:" + bcCheck.getProjName() + ")");
                    }
                    // 比对检查类型
                    if (!Objects.equals(dbCheck.getTypes(), bcCheck.getTypes())) {
                        tamperedFields.add("检查类型");
                    }
                    // 比对检测结果 (核心字段)
                    if (!Objects.equals(dbCheck.getResult(), bcCheck.getResult())) {
                        tamperedFields.add("检测结果");
                    }
                    // 比对关联的产品ID
                    /*if (!Objects.equals(dbCheck.getPid(), bcCheck.getPid())) {
                        //tamperedFields.add("关联产品ID");
                        tamperedFields.add("关联产品ID(本地:" + dbCheck.getPid() + " vs 链上:" + bcCheck.getPid() + ")");
                    }*/

                    if (tamperedFields.isEmpty()) {
                        isVerified = true;
                        verifyMsg = "校验通过：数据真实有效";
                    } else {
                        verifyMsg = "警告：发现数据篡改！";
                        log.warn("数据篡改报警: ID={}, CID={}, 差异={}", id, dbCheck.getCid(), tamperedFields);
                    }
                } else {
                    verifyMsg = "校验失败：链上未找到对应数据";
                }
            } catch (Exception e) {
                log.error("区块链连接异常，无法完成校验", e);
                verifyMsg = "校验中断：区块链网络连接超时";
            }
        }

        // 5. 封装校验结果到 params (不影响数据库结构)
        if (dbCheck.getParams() == null) {
            dbCheck.setParams(new java.util.HashMap<>());
        }
        dbCheck.getParams().put("isVerified", isVerified);
        dbCheck.getParams().put("verifyMsg", verifyMsg);
        dbCheck.getParams().put("tamperedFields", tamperedFields);

        // 6. 补充交易哈希和时间戳 (用于展示)
        AgriTx tx = txService.selectAgriTxByPid(dbCheck.getCid());
        if (tx != null) {
            dbCheck.setTxHash(tx.getTxid());
            dbCheck.setTimeStamp(tx.getTimestamp());
        }

        return AjaxResult.success(dbCheck);
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

    /**
     * 获取服务器局域网IP
     * 供前端生成二维码使用，解决前端无法获取真实IP的问题
     */
    @GetMapping("/get-server-ip")
    public AjaxResult getServerIp() {
        try {
            // 获取本机 IP 地址
            java.net.InetAddress inetAddress = java.net.InetAddress.getLocalHost();
            String ip = inetAddress.getHostAddress();
            return AjaxResult.success("操作成功", ip);
        } catch (Exception e) {
            return AjaxResult.error("获取IP失败");
        }
    }


}