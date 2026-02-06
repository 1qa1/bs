package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCOfficialCheck;
import com.ruoyi.system.domain.AgriOfficial;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriOfficialServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 官方检查信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriOfficialRetryTask {

    @Autowired
    private AgriOfficialServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行官方检查信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的官方检查记录
        AgriOfficial query = new AgriOfficial();
        query.setStatus(2);
        List<AgriOfficial> failedList = service.selectAgriOfficialList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的官方检查记录");
            return;
        }

        for (AgriOfficial official : failedList) {
            try {
                log.info("正在重试上链官方检查记录: OID={}", official.getOid());

                // 2. 重新构建上链对象
                AgriBCOfficialCheck bcOfficial = new AgriBCOfficialCheck();
                bcOfficial.setID(official.getOid());
                bcOfficial.setPid(official.getPid());
                bcOfficial.setReportTime(official.getReportTime());
                bcOfficial.setReportResult(official.getReportResult());
                bcOfficial.setReportUploadsUrl(official.getReportUploadsUrl());

                // 3. 再次尝试上链
                service.submitOfficial(bcOfficial);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    official.setTxHash(tx.getTxid());
                    official.setTimeStamp(tx.getTimestamp());
                    official.setStatus(1); // 修正状态为成功
                    service.updateAgriOfficial(official);

                    // 5. 补录交易记录
                    tx.setPid(official.getOid());
                    txService.insertAgriTx(tx);

                    log.info("官方检查记录 OID={} 补偿上链成功, TxHash={}", official.getOid(), tx.getTxid());
                } else {
                    log.warn("官方检查记录 OID={} 上链看似成功但未获取到TxHash", official.getOid());
                }

            } catch (Exception e) {
                log.error("官方检查记录 OID={} 补偿上链再次失败: {}", official.getOid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}