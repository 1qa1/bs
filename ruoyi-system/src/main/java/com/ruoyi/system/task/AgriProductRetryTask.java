package com.ruoyi.system.task;

import com.ruoyi.system.domain.AgriBCProduct;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import com.ruoyi.system.service.impl.AgriTxServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
@EnableScheduling
public class AgriProductRetryTask {

    @Autowired
    private AgriProductServiceImpl service;

    @Autowired
    private AgriTxServiceImpl txService;

    /**
     * 每隔 5 分钟执行一次，扫描上链失败的数据并重试
     */
    @Scheduled(cron = "0 0/5 * * * ?")
    public void retryUploadToBlockchain() {
        log.info("开始执行上链失败补偿任务...");

        // 1. 查询所有状态为 2 (失败) 或者 状态为 0 且创建时间超过 10分钟的数据
        // 这里为了演示简单，我们假设你只查 status = 2 的
        AgriProduct query = new AgriProduct();
        query.setStatus(2);
        List<AgriProduct> failedProducts = service.selectAgriProductList(query);

        for (AgriProduct product : failedProducts) {
            try {
                log.info("正在重试上链产品: {}", product.getName());

                // 2. 重新构建上链对象
                AgriBCProduct bcProduct = new AgriBCProduct();
                bcProduct.setID(product.getPid());
                bcProduct.setProductName(product.getName() == null ? "" : product.getName());
                bcProduct.setOnlyCode(product.getOnlyCode() == null ? "" : product.getOnlyCode());
                bcProduct.setTP(product.getTp() == null ? "" : product.getTp());
                bcProduct.setPlantCity(product.getPlantCity() == null ? "" : product.getPlantCity());
                try {
                    if (product.getNumber() != null && !product.getNumber().isEmpty()) {
                        bcProduct.setNumber(Integer.parseInt(product.getNumber()));
                    } else {
                        bcProduct.setNumber(0);
                    }
                } catch (Exception e) {
                    bcProduct.setNumber(0);
                }

                // 3. 再次尝试上链 (同步执行即可，因为是在定时任务里)
                service.submitProduct(bcProduct);

                // 4. 获取 Hash 并更新数据库
                AgriTx tx = service.queryTxHash();
                product.setTxHash(tx.getTxid());
                product.setTimeStamp(tx.getTimestamp());
                product.setStatus(1); // 修正为成功
                service.updateAgriProduct(product);

                // 5. 补录交易记录
                tx.setPid(product.getPid());
                txService.insertAgriTx(tx);

                log.info("产品 {} 补偿上链成功", product.getName());

            } catch (Exception e) {
                log.error("产品 {} 补偿上链再次失败: {}", product.getName(), e.getMessage());
                // 依然保持 status = 2，等待下一次重试，或者增加重试次数限制
            }
        }
    }
}