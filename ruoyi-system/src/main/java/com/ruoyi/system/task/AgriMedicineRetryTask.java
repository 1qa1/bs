package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCMedicine;
import com.ruoyi.system.domain.AgriMedicine;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriMedicineServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 用药信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriMedicineRetryTask {

    @Autowired
    private AgriMedicineServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行用药信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的用药记录
        AgriMedicine query = new AgriMedicine();
        query.setStatus(2);
        List<AgriMedicine> failedList = service.selectAgriMedicineList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的用药记录");
            return;
        }

        for (AgriMedicine medicine : failedList) {
            try {
                log.info("正在重试上链用药记录: MID={}", medicine.getMid());

                // 2. 重新构建上链对象
                AgriBCMedicine bcMedicine = new AgriBCMedicine();
                bcMedicine.setID(medicine.getMid());
                bcMedicine.setPid(medicine.getGid()); // 注意映射：业务 PID/GID
                bcMedicine.setName(medicine.getName());
                bcMedicine.setBatchNo(medicine.getBatchNo());
                bcMedicine.setUseTime(medicine.getUseTime());
                bcMedicine.setAmount(medicine.getAmount());

                // 3. 再次尝试上链
                service.submitMedicine(bcMedicine);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    medicine.setTxHash(tx.getTxid());
                    medicine.setTimeStamp(tx.getTimestamp());
                    medicine.setStatus(1); // 修正状态为成功
                    service.updateAgriMedicine(medicine);

                    // 5. 补录交易记录
                    tx.setPid(medicine.getMid());
                    txService.insertAgriTx(tx);

                    log.info("用药记录 MID={} 补偿上链成功, TxHash={}", medicine.getMid(), tx.getTxid());
                } else {
                    log.warn("用药记录 MID={} 上链看似成功但未获取到TxHash", medicine.getMid());
                }

            } catch (Exception e) {
                log.error("用药记录 MID={} 补偿上链再次失败: {}", medicine.getMid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}
