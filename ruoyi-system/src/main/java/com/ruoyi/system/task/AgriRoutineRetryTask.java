package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCRoutineCheck;
import com.ruoyi.system.domain.AgriRoutine;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriRoutineServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 日常检查信息上链补偿任务
 * 扫描状态为失败 (status=2) 的记录并重新尝试上链
 */
@Slf4j
@Component
@EnableScheduling
public class AgriRoutineRetryTask {

    @Autowired
    private AgriRoutineServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行日常检查信息上链补偿任务...");

        // 1. 查询所有状态为 2 (上链失败) 的日常检查记录
        AgriRoutine query = new AgriRoutine();
        query.setStatus(2);
        List<AgriRoutine> failedList = service.selectAgriRoutineList(query);

        if (failedList == null || failedList.isEmpty()) {
            log.info("未发现需要补偿的日常检查记录");
            return;
        }

        for (AgriRoutine routine : failedList) {
            try {
                log.info("正在重试上链日常检查记录: RID={}", routine.getRid());

                // 2. 重新构建上链对象
                AgriBCRoutineCheck bcRoutine = new AgriBCRoutineCheck();
                bcRoutine.setID(routine.getRid());
                bcRoutine.setPid(routine.getPid());
                bcRoutine.setCheckName(routine.getCheckName());
                bcRoutine.setCheckTime(routine.getCheckTime());
                bcRoutine.setProblems(routine.getProblems());
                bcRoutine.setProposal(routine.getProposal());
                bcRoutine.setOrgMember(routine.getOrgMember());
                bcRoutine.setUploadsUrl(routine.getUploadsUrl());

                // 3. 再次尝试上链
                service.submitRoutineCheck(bcRoutine);

                // 4. 获取交易 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                if (tx != null) {
                    routine.setTxHash(tx.getTxid());
                    routine.setTimeStamp(tx.getTimestamp());
                    routine.setStatus(1); // 修正状态为成功
                    service.updateAgriRoutine(routine);

                    // 5. 补录交易记录
                    tx.setPid(routine.getRid());
                    txService.insertAgriTx(tx);

                    log.info("日常检查记录 RID={} 补偿上链成功, TxHash={}", routine.getRid(), tx.getTxid());
                } else {
                    log.warn("日常检查记录 RID={} 上链看似成功但未获取到TxHash", routine.getRid());
                }

            } catch (Exception e) {
                log.error("日常检查记录 RID={} 补偿上链再次失败: {}", routine.getRid(), e.getMessage());
                // 保持 status=2，等待下一次重试
            }
        }
    }
}