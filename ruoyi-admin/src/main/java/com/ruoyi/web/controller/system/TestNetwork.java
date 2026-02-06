package com.ruoyi.web.controller.system;

import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.AgriProductServiceImpl;
import org.hyperledger.fabric.client.GatewayException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/")
public class TestNetwork {

    @Autowired
    private AgriProductServiceImpl service;

    @GetMapping("/")
    public AgriTx getTxInfo( ) throws GatewayException {
        return service.queryTxHash();
    }
}
