package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCGrow;
import com.ruoyi.system.domain.AgriGrow;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriGrowServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 种植信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriGrowRetryTask {

    @Autowired
    private AgriGrowServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行种植信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的种植记录
        AgriGrow query = new AgriGrow();
        query.setStatus(2);
        List<AgriGrow> failedList = service.selectAgriGrowList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的种植记录");
            return;
        }

        for (AgriGrow grow : failedList) {
            try {
                log.info("正在重试上链种植记录: GID={}", grow.getGid());

                // 2. 重新构建上链对象
                AgriBCGrow bcGrow = new AgriBCGrow();
                bcGrow.setID(grow.getGid());
                bcGrow.setPid(grow.getPid());
                bcGrow.setPlantTime(grow.getPlantTime());
                bcGrow.setReapTime(grow.getReapTime());

                // 3. 再次尝试上链
                service.submitGrow(bcGrow);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    grow.setTxHash(tx.getTxid());
                    grow.setTimeStamp(tx.getTimestamp());
                    grow.setStatus(1); // 修正状态为成功
                    service.updateAgriGrow(grow);

                    // 5. 补录交易记录
                    tx.setPid(grow.getGid());
                    // 检查是否已存在交易记录，避免主键冲突(虽然Tx表通常是自增ID，但这里最好是insert)
                    // 简单起见直接 insert，若业务逻辑不同可调整
                    txService.insertAgriTx(tx);

                    log.info("种植记录 GID={} 补偿上链成功, TxHash={}", grow.getGid(), tx.getTxid());
                } else {
                    log.warn("种植记录 GID={} 上链看似成功但未获取到TxHash", grow.getGid());
                }

            } catch (Exception e) {
                log.error("种植记录 GID={} 补偿上链再次失败: {}", grow.getGid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}
