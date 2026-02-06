package com.ruoyi.system.blockchain.update;

import com.ruoyi.system.domain.*;
import com.ruoyi.system.properties.HyperLedgerFabricProperties;
import lombok.AllArgsConstructor;
import org.hyperledger.fabric.client.*;
import org.springframework.stereotype.Component;

@Component
@AllArgsConstructor
public class UpdateToBlockChain {

    final Gateway gateway;

    final Contract contract;

    final HyperLedgerFabricProperties hyperLedgerFabricProperties;

    //    种植端信息 => AgriBCGrow
    public int updateAgriBCGrow(AgriBCGrow agriBCGrow) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdatePlant",agriBCGrow.getID(), agriBCGrow.getPlantTime(), agriBCGrow.getReapTime());
        return 0;
    }

    //    产品信息  => AgriBCProduct
    public int updateAgriBCProduct(AgriBCProduct product) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateProduct",product.getID(),product.getProductName(),String.valueOf(product.getNumber()),product.getTP(),product.getPlantCity(),product.getOnlyCode());
        return 0;
    }


    // 自我检查信息 => AgriBCCheck
    public int updateAgriBCCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateCheck",check.getID(),check.getProjName(),check.getTypes(),check.getResult(),check.getUploadsUrl());
        return 0;
    }

    // 肥料信息 => AgriBCFertilizer
    public int updateAgriBCFertilizer(AgriBCFertilizer fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateFertilizer",fertilizer.getID(),fertilizer.getName(),fertilizer.getCompany(),fertilizer.getBatchNo(),fertilizer.getUseTime());

        return 0;
    }

    //    医药信息 => AgriBCMedicine
    public int updateAgriBCMedicine(AgriBCMedicine medicine) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateMedicine",medicine.getID(),medicine.getName(),medicine.getBatchNo(),medicine.getUseTime(),medicine.getAmount());
        return 0;
    }

    //    官方抽查信息 => AgriBCOfficialCkeck
    public int updateAgriBCOfficial( AgriBCOfficialCheck check  ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateOfficialCheck",check.getID(),check.getReportTime(),check.getReportResult(),check.getReportUploadsUrl());
        return 0;
    }

    // 售卖信息 => AgriBCSell
    public int updateAgriBCSell( AgriBCSell sell ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateSell",sell.getID(),sell.getArrivalTime(),sell.getAmount(),sell.getTp(),sell.getCheckTime(),sell.getCheckName(),sell.getCheckResult());
        return 0;
    }

    // 运输信息 => AgriBCTransport
    public int updateAgriBCTransportation( AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateDriver",transport.getID(),transport.getDriverName(),transport.getPhone(),transport.getCarNumber(),transport.getStartCity(),transport.getEndCity(),transport.getStartTime(),transport.getProductAmount(),transport.getTp());
        return 0;
    }

    // 日常巡查信息 => AgriBCRoutineCheck
    public int updateAgriBCRoutine( AgriBCRoutineCheck check ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        contract.submitTransaction("UpdateInspectorCheck",check.getID(),check.getCheckTime(),check.getCheckName(),check.getProblems(),check.getProposal(),check.getOrgMember(),check.getUploadsUrl());
        return 0;
    }
}
