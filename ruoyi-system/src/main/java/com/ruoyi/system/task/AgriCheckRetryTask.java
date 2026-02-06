package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCCheck;
import com.ruoyi.system.domain.AgriCheck;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriCheckServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 检测信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriCheckRetryTask {

    @Autowired
    private AgriCheckServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行检测信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的检测记录
        AgriCheck query = new AgriCheck();
        query.setStatus(2);
        List<AgriCheck> failedList = service.selectAgriCheckList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的检测记录");
            return;
        }

        for (AgriCheck check : failedList) {
            try {
                log.info("正在重试上链检测记录: CID={}", check.getCid());

                // 2. 重新构建上链对象
                AgriBCCheck bcCheck = new AgriBCCheck();
                bcCheck.setID(check.getCid());
                bcCheck.setPid(check.getGid()); // 注意：这里将 gid 传给 Pid 字段
                bcCheck.setProjName(check.getProjName());
                bcCheck.setTypes(check.getTypes());
                bcCheck.setResult(check.getResult());
                bcCheck.setUploadsUrl(check.getUploadsUrl());

                // 3. 再次尝试上链
                service.submitCheck(bcCheck);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    check.setTxHash(tx.getTxid());
                    check.setTimeStamp(tx.getTimestamp());
                    check.setStatus(1); // 修正状态为成功
                    service.updateAgriCheck(check);

                    // 5. 补录交易记录
                    tx.setPid(check.getCid());
                    txService.insertAgriTx(tx);

                    log.info("检测记录 CID={} 补偿上链成功, TxHash={}", check.getCid(), tx.getTxid());
                } else {
                    log.warn("检测记录 CID={} 上链看似成功但未获取到TxHash", check.getCid());
                }

            } catch (Exception e) {
                log.error("检测记录 CID={} 补偿上链再次失败: {}", check.getCid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}