package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCSell;
import com.ruoyi.system.domain.AgriSell;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriSellServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 售卖信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriSellRetryTask {

    @Autowired
    private AgriSellServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行售卖信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的售卖记录
        AgriSell query = new AgriSell();
        query.setStatus(2);
        List<AgriSell> failedList = service.selectAgriSellList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的售卖记录");
            return;
        }

        for (AgriSell sell : failedList) {
            try {
                log.info("正在重试上链售卖记录: SID={}", sell.getSid());

                // 2. 重新构建上链对象
                AgriBCSell bcSell = new AgriBCSell();
                bcSell.setID(sell.getSid());
                bcSell.setPid(sell.getPid());
                bcSell.setArrivalTime(sell.getArrivalTime());
                bcSell.setAmount(sell.getAmount());
                bcSell.setCheckTime(sell.getCheckTime());
                bcSell.setCheckName(sell.getCheckName());
                bcSell.setCheckResult(sell.getCheckResult());
                bcSell.setTp(sell.getTp());

                // 3. 再次尝试上链
                service.submitSell(bcSell);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    sell.setTxHash(tx.getTxid());
                    sell.setTimeStamp(tx.getTimestamp());
                    sell.setStatus(1); // 修正状态为成功
                    service.updateAgriSell(sell);

                    // 5. 补录交易记录
                    tx.setPid(sell.getSid());
                    txService.insertAgriTx(tx);

                    log.info("售卖记录 SID={} 补偿上链成功, TxHash={}", sell.getSid(), tx.getTxid());
                } else {
                    log.warn("售卖记录 SID={} 上链看似成功但未获取到TxHash", sell.getSid());
                }

            } catch (Exception e) {
                log.error("售卖记录 SID={} 补偿上链再次失败: {}", sell.getSid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}