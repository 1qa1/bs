package com.ruoyi.system.blockchain.submit;

import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.properties.HyperLedgerFabricProperties;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.hyperledger.fabric.client.*;
import org.springframework.stereotype.Component;

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
@Slf4j
@Component
@AllArgsConstructor
public class SubmitToBlockChain {

    final Gateway gateway;

    final Contract contract;

    final HyperLedgerFabricProperties hyperLedgerFabricProperties;

//    种植端信息 => AgriBCGrow
    public int insertAgriBCGrow(AgriBCGrow agriBCGrow) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreatePlant")
                .addArguments(agriBCGrow.getID(), agriBCGrow.getPlantTime(), agriBCGrow.getReapTime())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    //    产品信息  => AgriBCProduct
    public int insertAgriBCProduct(AgriBCProduct product) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateProduct")
                .addArguments(product.getID(),product.getProductName(), String.valueOf(product.getNumber()),product.getTP(),product.getPlantCity(),product.getOnlyCode())
                .build()
                .endorse()
                .submit();
        return 0;
    }


    // 自我检查信息 => AgriBCCheck
    public int insertAgriBCCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateCheck")
                .addArguments(check.getID(),check.getProjName(),check.getTypes(),check.getResult(),check.getUploadsUrl())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    // 肥料信息 => AgriBCFertilizer
        public int insertAgriBCFertilizer(AgriBCFertilizer fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException {
            byte[] createPlants = contract.newProposal("CreateFertilizer")
                    .addArguments(fertilizer.getID(),fertilizer.getName(),fertilizer.getCompany(),fertilizer.getBatchNo(),fertilizer.getUseTime())
                    .build()
                    .endorse()
                    .submit();
            return 0;
        }

    //    医药信息 => AgriBCMedicine
    public int insertAgriBCMedicine(AgriBCMedicine medicine) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateMedicine")
                .addArguments(medicine.getID(),medicine.getName(),medicine.getBatchNo(),medicine.getUseTime(),medicine.getAmount())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    //    官方抽查信息 => AgriBCOfficialCkeck
    public int insertAgriBCOfficial( AgriBCOfficialCheck check  ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateOfficialCheck")
                .addArguments(check.getID(),check.getReportTime(),check.getReportResult(),check.getReportUploadsUrl())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    // 售卖信息 => AgriBCSell
    public int insertAgriBCSell( AgriBCSell sell ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateSell")
                .addArguments(sell.getID(),sell.getArrivalTime(),sell.getAmount(),sell.getTp(),sell.getCheckTime(),sell.getCheckName(),sell.getCheckResult())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    // 运输信息 => AgriBCTransport
    public int insertAgriBCTransportation( AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateDriver")
                .addArguments(transport.getID(),transport.getDriverName(),transport.getPhone(),transport.getCarNumber(),transport.getStartCity(),transport.getEndCity(),transport.getStartTime(),transport.getProductAmount(),transport.getTp())
                .build()
                .endorse()
                .submit();
        return 0;
    }

    // 日常巡查信息 => AgriBCRoutineCheck
    public int insertAgriBCRoutine( AgriBCRoutineCheck check ) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        byte[] createPlants = contract.newProposal("CreateInspectorCheck")
                .addArguments(check.getID(),check.getCheckTime(),check.getCheckName(),check.getProblems(),check.getProposal(),check.getOrgMember(),check.getUploadsUrl())
                .build()
                .endorse()
                .submit();
        return 0;
    }

}

