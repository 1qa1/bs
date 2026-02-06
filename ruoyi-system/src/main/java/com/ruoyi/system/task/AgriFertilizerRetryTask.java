package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCFertilizer;
import com.ruoyi.system.domain.AgriFertilizer;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriFertilizerServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 肥料信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriFertilizerRetryTask {

    @Autowired
    private AgriFertilizerServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行肥料信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的肥料记录
        AgriFertilizer query = new AgriFertilizer();
        query.setStatus(2);
        List<AgriFertilizer> failedList = service.selectAgriFertilizerList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的肥料记录");
            return;
        }

        for (AgriFertilizer fertilizer : failedList) {
            try {
                log.info("正在重试上链肥料记录: FID={}", fertilizer.getFid());

                // 2. 重新构建上链对象
                AgriBCFertilizer bcFertilizer = new AgriBCFertilizer();
                bcFertilizer.setID(fertilizer.getFid());
                // 注意：根据 Controller 逻辑，这里将 gid 传给 Pid 字段 (对应链上结构)
                bcFertilizer.setPid(fertilizer.getGid());
                bcFertilizer.setName(fertilizer.getName());
                bcFertilizer.setCompany(fertilizer.getCompany());
                bcFertilizer.setBatchNo(fertilizer.getBatchNo());
                bcFertilizer.setUseTime(fertilizer.getUseTime());

                // 3. 再次尝试上链
                service.submitFertilizer(bcFertilizer);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    fertilizer.setTxHash(tx.getTxid());
                    fertilizer.setTimeStamp(tx.getTimestamp());
                    fertilizer.setStatus(1); // 修正状态为成功
                    service.updateAgriFertilizer(fertilizer);

                    // 5. 补录交易记录
                    tx.setPid(fertilizer.getFid());
                    txService.insertAgriTx(tx);

                    log.info("肥料记录 FID={} 补偿上链成功, TxHash={}", fertilizer.getFid(), tx.getTxid());
                } else {
                    log.warn("肥料记录 FID={} 上链看似成功但未获取到TxHash", fertilizer.getFid());
                }

            } catch (Exception e) {
                log.error("肥料记录 FID={} 补偿上链再次失败: {}", fertilizer.getFid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}