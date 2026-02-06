package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCTransport;
import com.ruoyi.system.domain.AgriTransport;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriTransportServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 运输信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriTransportRetryTask {

    @Autowired
    private AgriTransportServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行运输信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的运输记录
        AgriTransport query = new AgriTransport();
        query.setStatus(2);
        List<AgriTransport> failedList = service.selectAgriTransportList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的运输记录");
            return;
        }

        for (AgriTransport transport : failedList) {
            try {
                log.info("正在重试上链运输记录: TID={}", transport.getTid());

                // 2. 重新构建上链对象
                AgriBCTransport bcTransport = new AgriBCTransport();
                bcTransport.setID(transport.getTid());
                bcTransport.setPid(transport.getPid());
                bcTransport.setDriverName(transport.getDriverName());
                bcTransport.setPhone(transport.getPhone());
                bcTransport.setCarNumber(transport.getCarNumber());
                bcTransport.setProductAmount(transport.getProductAmount());
                bcTransport.setStartCity(transport.getStartCity());
                bcTransport.setTp(transport.getTp());
                bcTransport.setEndCity(transport.getEndCity());
                bcTransport.setStartTime(transport.getStartTime());

                // 3. 再次尝试上链
                service.submitTransport(bcTransport);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    transport.setTxHash(tx.getTxid());
                    transport.setTimeStamp(tx.getTimestamp());
                    transport.setStatus(1); // 修正状态为成功
                    service.updateAgriTransport(transport);

                    // 5. 补录交易记录
                    tx.setPid(transport.getTid());
                    txService.insertAgriTx(tx);

                    log.info("运输记录 TID={} 补偿上链成功, TxHash={}", transport.getTid(), tx.getTxid());
                } else {
                    log.warn("运输记录 TID={} 上链看似成功但未获取到TxHash", transport.getTid());
                }

            } catch (Exception e) {
                log.error("运输记录 TID={} 补偿上链再次失败: {}", transport.getTid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}