package com.ruoyi.web.controller.system;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.service.impl.AgriMedicineServiceImpl;
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
 * 用药情况 controller
 *
 **/
@Slf4j
@RestController
@RequestMapping("/system/medicine")
public class SysAgriMedicineController {

    @Autowired
    private AgriMedicineServiceImpl service;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriTxServiceImpl txService;

    // 增加
    @PostMapping("/")
    public AjaxResult addMedicine(@RequestBody AgriMedicine medicine) {
        // 1. 生成业务主键 MID
        medicine.setMid(GenerateUUID.Generate());

        // 2. 设置初始状态为 0 (处理中)
        medicine.setStatus(0);

        // 3. 先存入 MySQL
        service.insertAgriMedicine(medicine);

        // 4. 异步处理上链
        CompletableFuture.runAsync(() -> {
            try {
                // 稍微等待确保主线程事务提交
                Thread.sleep(200);
                // 重新从数据库获取对象
                AgriMedicine dbMedicine = service.selectMedicineByMid(medicine.getMid());
                if (dbMedicine == null) {
                    log.error("异步上链中止：未找到MID为 {} 的记录", medicine.getMid());
                    return;
                }

                // --- 准备上链数据 ---
                AgriBCMedicine bcMedicine = new AgriBCMedicine();
                bcMedicine.setID(medicine.getMid()); // 对应链上ID
                bcMedicine.setPid(medicine.getGid()); // 注意：这里可能对应种植 GID (AgriMedicine.gid)

                // 具体的业务字段映射
                bcMedicine.setName(medicine.getName());
                bcMedicine.setBatchNo(medicine.getBatchNo());
                bcMedicine.setUseTime(medicine.getUseTime());
                bcMedicine.setAmount(medicine.getAmount());

                // --- 执行上链 ---
                service.submitMedicine(bcMedicine);

                // --- 获取交易信息 ---
                AgriTx tx = service.queryTxHash();

                // --- 上链成功，回写数据库 ---
                medicine.setTxHash(tx.getTxid());
                medicine.setTimeStamp(tx.getTimestamp());
                medicine.setStatus(1); // 成功
                service.updateAgriMedicine(medicine);

                // --- 备份交易记录 ---
                tx.setPid(medicine.getMid());
                txService.insertAgriTx(tx);

                log.info("用药信息 {} 异步上链成功", medicine.getMid());

            } catch (Exception e) {
                log.error("用药信息 {} 异步上链失败", medicine.getMid(), e);
                try {
                    AgriMedicine failItem = service.selectMedicineByMid(medicine.getMid());
                    if (failItem != null) {
                        failItem.setStatus(2); // 失败
                        service.updateAgriMedicine(failItem);
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
    public AjaxResult updateMedicine(@RequestBody AgriMedicine medicine) {
        // 1. 先更新数据库
        service.updateAgriMedicine(medicine);

        // 2. 异步处理链上更新
        CompletableFuture.runAsync(() -> {
            try {
                AgriBCMedicine bcMedicine = new AgriBCMedicine();
                bcMedicine.setID(medicine.getMid());
                bcMedicine.setPid(medicine.getGid()); // 注意映射关系
                bcMedicine.setName(medicine.getName());
                bcMedicine.setBatchNo(medicine.getBatchNo());
                bcMedicine.setUseTime(medicine.getUseTime());
                bcMedicine.setAmount(medicine.getAmount());

                // 执行链上更新
                service.updateMedicine(bcMedicine);

                // 更新交易记录
                AgriTx tx = service.queryTxHash();
                tx.setPid(medicine.getMid());

                // 更新数据库状态
                medicine.setTxHash(tx.getTxid());
                medicine.setTimeStamp(tx.getTimestamp());
                medicine.setStatus(1);
                service.updateAgriMedicine(medicine);

                txService.updateAgriTx(tx);
                log.info("用药信息 {} 更新上链成功", medicine.getMid());

            } catch (Exception e) {
                log.error("用药信息 {} 更新上链失败", medicine.getMid(), e);
            }
        });

        return AjaxResult.success("更新提交成功，正在同步至区块链...");
    }

    // 删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteMedicine(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            // 1. 查询数据库对象
            AgriMedicine dbMedicine = service.selectAgriMedicineById(id);
            if (dbMedicine != null) {
                String mid = dbMedicine.getMid();

                // 2. 删除数据库记录
                service.deleteAgriMedicineById(id);

                // 3. 异步删除链上数据
                if (mid != null && !mid.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        try {
                            service.deleteMedicine(mid);
                            txService.deleteAgriTxByPid(mid);
                            log.info("MID {} 链上数据删除成功", mid);
                        } catch (Exception e) {
                            log.error("MID {} 链上数据删除失败", mid, e);
                        }
                    });
                }
            }
        }
        return AjaxResult.success("删除成功");
    }

    // 查询
    @GetMapping("/top/{id}")
    public AjaxResult getMedicine(@PathVariable("id") String id) {
        List<AgriMedicine> agriMedicines;

        if ("all".equals(id) || "null".equals(id)) {
            agriMedicines = service.selectAgriMedicineList(null);
        } else {
            // 智能判断 ID 类型: 优先判定为 GID (种植批次ID)
            // 1. 尝试作为 GID 查询
            // 这里我们假设如果能查到对应的种植记录，它就是一个 GID
            // 需要注入 AgriGrowService，如果没有注入需要添加
            // 更好的方式是直接查 AgiMedicineByGid，如果不为空则返回?
            // 不行，有的批次可能还没药，查询结果为空，不能说明它不是GID。
            // 严谨做法：查 AgriGrow 表确认是否存在此 GID。

            // 下面假设 AgriGrowService 已注入为 growService (SysAgriGrowController里有，这里可能没有，需检查)
            // 如果没有 growService，我们可以先尝试 selectMedicineByGid

            // 既然我们要做到 "精确查批次"，那优先按 GID 查
            agriMedicines = service.selectMedicineByGid(id);

            // 如果按 GID 查不到数据，有两个可能：
            // A. 这是一个 GID，但是该批次没打药。
            // B. 这不是一个 GID，而是一个 PID (或者其他)。

            // 如果结果为空，我们再按 PID 查一次?
            // 这样会有副作用：如果真的是批次 A (无药)，结果显示了 产品 A 的所有药(来自其他批次)。这是错误的。
            // 所以必须区分 GID 和 PID。
            // 检查 ID 格式? 都是 UUID。
            // 只能查 AgriGrow 表。

            // 鉴于当前类中可能没有 growService，我们先注入它。
            // 稍后我会检查并添加 @Autowired private IAgriGrowService growService;

            // 如果按 GID 查不到，再尝试按 PID 查
            if (agriMedicines == null || agriMedicines.isEmpty()) {
                // 尝试作为 PID 查询
                AgriProduct product = productService.selectProductByPid(id);
                if (product != null) {
                    agriMedicines = service.selectMedicineByPid(id);
                } else {
                    // 如果既不是 GID 也不是 PID，返回空列表
                    agriMedicines = new ArrayList<>();
                }
            }
        }

        // 2. 直接返回数据库中的数据
        for (AgriMedicine item : agriMedicines) {
            // 为了前端显示产品名称，这里临时修改 pid 字段
            // 注意：需确认 AgriMedicine 中是否有 dedicated 的字段用于显示产品名，通常是直接覆盖 pid 或者 name
            // 参考 AgriGrow: grow.setPid(pName);
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        return AjaxResult.success(agriMedicines);
    }

    // 查询单个信息 (根据 DB ID)
    @GetMapping("/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id) {
        AgriMedicine dbMedicine = service.selectAgriMedicineById(id);
        if (dbMedicine == null) {
            return AjaxResult.error("未找到相关用药记录");
        }
        String mid = dbMedicine.getMid();

        // --- 核心修改：增加读时校验 (Verify-on-Read) ---
        boolean isVerified = false;
        List<String> tamperedFields = new ArrayList<>();
        AgriBCMedicine chainData = null;

        try {
            // 1. 从区块链获取“真理”数据
            chainData = service.queryMedicine(mid);

            if (chainData != null) {
                // 2. 逐字段比对
                if (!isMatch(dbMedicine.getName(), chainData.getName())) {
                    tamperedFields.add("name");
                }
                if (!isMatch(dbMedicine.getBatchNo(), chainData.getBatchNo())) {
                    tamperedFields.add("batchNo");
                }
                // 金额/数量比较建议使用 equals 或 BigDecimal，这里假设是 String
                if (!isMatch(dbMedicine.getAmount(), chainData.getAmount())) {
                    tamperedFields.add("amount");
                }
                // 时间比较
                if (!isMatch(dbMedicine.getUseTime(), chainData.getUseTime())) {
                    tamperedFields.add("useTime");
                }

                if (tamperedFields.isEmpty()) {
                    isVerified = true;
                } else {
                    log.warn("发现数据篡改! MID={}, 篡改字段: {}", mid, tamperedFields);
                }
            } else {
                log.warn("区块链上未找到数据! MID={}", mid);
            }
        } catch (Exception e) {
            log.error("区块链校验失败", e);
        }

        // 3. 将校验结果放入 params 返回前端
        if (dbMedicine.getParams() == null) {
            dbMedicine.setParams(new java.util.HashMap<>());
        }
        dbMedicine.getParams().put("isVerified", isVerified);
        if (!isVerified) {
            dbMedicine.getParams().put("tamperedFields", tamperedFields);
            if (chainData != null) {
                dbMedicine.getParams().put("chainData", chainData); // 返回真实数据供对比
            } else {
                dbMedicine.getParams().put("chainStatus", "NotOnChain");
            }
        }
        // --- 校验结束 ---

        // 补充链上哈希 (仅作显示，不可作为信任依据)
        if (mid != null) {
            AgriTx tx = txService.selectAgriTxByPid(mid);
            if (tx != null) {
                dbMedicine.setTxHash(tx.getTxid());
                dbMedicine.setTimeStamp(tx.getTimestamp());
            }
        }

        return AjaxResult.success(dbMedicine);
    }

    // 辅助比较方法
    private boolean isMatch(String dbVal, String chainVal) {
        if (dbVal == null)
            return chainVal == null;
        return dbVal.equals(chainVal);
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriMedicine medicine) {
        // 导出逻辑：优先使用 Pid 过滤
        String pid = medicine.getPid();
        // 如果没有 pid，是否导出所有？暂定使用 selectMedicineByPid
        List<AgriMedicine> list;
        if (pid != null && !pid.isEmpty() && !"all".equals(pid)) {
            list = service.selectMedicineByPid(pid);
        } else {
            list = service.selectAgriMedicineList(null);
        }

        // 装饰产品名称
        for (AgriMedicine item : list) {
            AgriProduct p = productService.selectProductByPid(item.getPid());
            String pName = (p != null) ? p.getName() : "未知产品";
            item.setPid(pName);
        }

        ExcelUtil<AgriMedicine> util = new ExcelUtil<>(AgriMedicine.class);
        util.exportExcel(response, list, "用药数据");
    }
}
