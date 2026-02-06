package com.ruoyi.system.blockchain.delete;

import com.alibaba.fastjson.JSONArray;
import com.ruoyi.system.properties.HyperLedgerFabricProperties;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.google.gson.GsonBuilder;
import com.google.gson.Gson;

/**
 *  fabric 上链操作  将数据提交到fabric的世界状态中
 *  以下数据需要上链
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
@Slf4j
public class DeleteFromBlockChain {

    final Gateway gateway;

    final Contract contract;

    final HyperLedgerFabricProperties hyperLedgerFabricProperties;

    @Autowired
    private Network network;

    // 删除 种植信息
    public int deleteAgriBCGrow( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeletePlant",id);
        return 0;
    }

    //    删除 产品信息
    public int deleteAgriBCProduct( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteProduct",id);
        return 0;
    }

    // 删除 自我检查信息
    public int deleteAgriBCCheck(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteCheck",id);
        return 0;
    }

    // 删除 肥料信息
    public int deleteAgriBCFertilizer( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteFertilizer",id);
        return 0;
    }

    // 删除 医药信息
    public int deleteAgriBCMedicine( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteMedicine",id);
        return 0;
    }

    // 删除 售卖信息
    public int deleteAgriBCSell( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteSell",id);
        return 0;
    }

    // 删除 官方抽查信息
    public int deleteAgriBCOfficialCheck( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteOfficialCheck",id);
        return 0;
    }

    // 删除 运输信息
    public int deleteAgriBCTransport( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteDriver",id);
        return 0;
    }
    //   删除 日常巡查信息
    public int deleteAgriBCRoutineCheck( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("DeleteInspectorCheck",id);
        return 0;
    }

    public void getAssert() {
        CloseableIterator<ChaincodeEvent> events = network.getChaincodeEvents("system");
        log.info("chaincodeEvents {} " , events);

        while (events.hasNext()) {
            ChaincodeEvent event = events.next();

            log.info("receive chaincode event {} , block number {} , payload {} "
                    , event.getEventName() , event.getBlockNumber() , JSONArray.toJSON(Base64.decodeBase64(event.getPayload())));

        }
    }
}
