package com.ruoyi.system.blockchain.query;

import com.alibaba.fastjson.JSON;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.properties.HyperLedgerFabricProperties;
import lombok.AllArgsConstructor;
import org.apache.commons.codec.binary.StringUtils;
import org.hyperledger.fabric.client.Contract;
import org.hyperledger.fabric.client.Gateway;
import org.hyperledger.fabric.client.GatewayException;
import org.springframework.stereotype.Component;

/**
 *  fabric 查询操作  从fabric中查询数据
 *  以下数据需要查询
 *  1、种植端信息 => AgriBCGrow
 *  2. 产品信息  => AgriBCProduct
 *  3. 自我检查信息 => AgriBCCheck
 *  4. 肥料信息 => AgriBCFertilizer
 *  5. 医药信息 => AgriBCMedicine
 *  6. 官方抽查信息 => AgriBCOfficialCkeck
 *  7. 售卖信息 => AgriBCSell
 *  8. 运输信息 => AgriBCTransport
 *  9. 日常巡查信息 => AgriBCRoutineCheck
 *
 * @create 2022/12/27
 **/

@Component
@AllArgsConstructor
public class QueryFromBlockChain {
    final Gateway gateway;

    final Contract contract;

    final HyperLedgerFabricProperties hyperLedgerFabricProperties;

    //    查询 种植信息
    public AgriBCGrow queryAgriBCGrow( String id ) throws GatewayException {
        byte[] queryPlants = contract.evaluateTransaction("QueryPlant", id);
        String s = StringUtils.newStringUtf8(queryPlants);
        AgriBCGrow grow = JSON.parseObject(s,AgriBCGrow.class);
        return grow;
    }
    //    查询 产品信息
    public AgriBCProduct queryAgriBCProduct (String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryProduct", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCProduct object = JSON.parseObject(s, AgriBCProduct.class);
        return object;
    }


    // 查询 自我检查信息
    public AgriBCCheck queryAgriBCCheck (String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryCheck", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCCheck object = JSON.parseObject(s,AgriBCCheck.class);
        return object;
    }

    // 查询  肥料信息
    public AgriBCFertilizer queryAgriBCFertilizer (String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryFertilizer", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCFertilizer object = JSON.parseObject(s,AgriBCFertilizer.class);
        return object;
    }

    // 查询  医药信息
    public AgriBCMedicine queryAgriBCMedicine (String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryMedicine", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCMedicine object = JSON.parseObject(s,AgriBCMedicine.class);
        return object;
    }

    // 查询 官方抽查信息
    public AgriBCOfficialCheck queryAgriBCOfficialCheck ( String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryOfficialCheck", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCOfficialCheck object = JSON.parseObject(s,AgriBCOfficialCheck.class);
        return object;
    }


    // 查询 售卖信息
    public AgriBCSell queryAgriBCSell ( String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QuerySell", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCSell object = JSON.parseObject(s,AgriBCSell.class);
        return object;
    }

    // 查询 运输信息
    public AgriBCTransport queryAgriBCTransport ( String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryDriver", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCTransport object = JSON.parseObject(s,AgriBCTransport.class);
        return object;
    }


    // 查询 日常巡查信息
    public AgriBCRoutineCheck queryAgriBCRoutineCheck ( String id ) throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryInspectorCheck", id);
        String s = StringUtils.newStringUtf8(query);
        AgriBCRoutineCheck object = JSON.parseObject(s,AgriBCRoutineCheck.class);
        return object;
    }

    public AgriTx queryTransaction() throws GatewayException {
        byte[] query = contract.evaluateTransaction("QueryTxInformation");
        String s = StringUtils.newStringUtf8(query);
        AgriTx tx = JSON.parseObject(s, AgriTx.class);
        return tx;
    }

}
