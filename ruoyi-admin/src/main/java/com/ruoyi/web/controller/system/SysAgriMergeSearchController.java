package com.ruoyi.web.controller.system;


import com.ruoyi.common.config.RuoYiConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.MimeTypeUtils;
import com.ruoyi.common.utils.uuid.IdUtils;
import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.domain.*;
import com.ruoyi.system.service.impl.*;
import com.ruoyi.system.utils.ConvertToMultipartFile;
import com.ruoyi.system.utils.GenerateUUID;
import com.ruoyi.system.utils.QRCodeUtils;
//import com.sun.org.apache.regexp.internal.RE;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * 自我检查 controller
 *
 * @return
 * @author sun
 * @create 2022/12/28
 **/

@RestController
@RequestMapping("/system/search/")
public class SysAgriMergeSearchController {

    /**
     * 1. checkService => check
     * 2. fertilizerService => fertilizer
     * 3. growService => grow
     * 4. medicineService => medicine
     * 5. officialService => official
     * 6. productService => product
     * 7. routineService => routine
     * 8. sellService => sell
     * 9. transportService => transport
     *
     **/


    @Autowired
    private AgriCheckServiceImpl checkService;

    @Autowired
    private AgriFertilizerServiceImpl fertilizerService;

    @Autowired
    private AgriGrowServiceImpl growService;

    @Autowired
    private AgriMedicineServiceImpl medicineService;

    @Autowired
    private AgriOfficialServiceImpl officialService;

    @Autowired
    private AgriProductServiceImpl productService;

    @Autowired
    private AgriRoutineServiceImpl routineService;

    @Autowired
    private AgriSellServiceImpl sellService;

    @Autowired
    private AgriTransportServiceImpl transportService;

    @Autowired
    private AgriTxServiceImpl txService;

//    check
    private List<AgriBCCheck> getBatchChecks(AgriCheckServiceImpl service,List<AgriCheck> dbChecks) throws GatewayException {
        List<AgriBCCheck> results = new ArrayList<>();
        for( AgriCheck check : dbChecks ){
            AgriBCCheck bcCheck = service.queryCheck(check.getCid());
            if (!Objects.isNull(bcCheck)) {
                AgriTx tx = txService.selectAgriTxByPid(bcCheck.getID());
                bcCheck.setTxHash(tx.getTxid());
                bcCheck.setTimeStamp(tx.getTimestamp());
                results.add(bcCheck);
            }

        }
        return results;
    }
//    officialCheck
    private List<AgriBCOfficialCheck> getBatchOfficialChecks(AgriOfficialServiceImpl service,List<AgriOfficial> dbOfficialChecks) throws GatewayException {
        List<AgriBCOfficialCheck> results = new ArrayList<>();

        for( AgriOfficial OfficialCheck : dbOfficialChecks ){
            AgriBCOfficialCheck bcOfficialCheck = service.queryOfficial(OfficialCheck.getOid());
            if (!Objects.isNull(bcOfficialCheck)) {
                AgriTx tx = txService.selectAgriTxByPid(bcOfficialCheck.getID());
                bcOfficialCheck.setTxHash(tx.getTxid());
                bcOfficialCheck.setTimeStamp(tx.getTimestamp());
                results.add(bcOfficialCheck);
            }
        }
        return results;
    }
    //    fertilizer
    private List<AgriBCFertilizer> getBatchFertilizers(AgriFertilizerServiceImpl service,List<AgriFertilizer> dbFertilizers) throws GatewayException {
        List<AgriBCFertilizer> results = new ArrayList<>();
        for( AgriFertilizer Fertilizer : dbFertilizers ){
            AgriBCFertilizer bcFertilizer = service.queryFertilizer(Fertilizer.getFid());
            if (!Objects.isNull(bcFertilizer)) {
                AgriTx tx = txService.selectAgriTxByPid(bcFertilizer.getID());
                bcFertilizer.setTxHash(tx.getTxid());
                bcFertilizer.setTimeStamp(tx.getTimestamp());
                results.add(bcFertilizer);
            }

        }
        return results;
    }

    //    grow
    private List<AgriBCGrow> getBatchGrows(AgriGrowServiceImpl service,List<AgriGrow> dbGrows) throws GatewayException {
        List<AgriBCGrow> results = new ArrayList<>();

        for( AgriGrow Grow : dbGrows ){
            AgriBCGrow bcGrow = service.queryGrow(Grow.getGid());
            if (!Objects.isNull(bcGrow)) {
                AgriTx tx = txService.selectAgriTxByPid(bcGrow.getID());
                bcGrow.setTxHash(tx.getTxid());
                bcGrow.setTimeStamp(tx.getTimestamp());
                results.add(bcGrow);
            }

        }
        return results;
    }

    //medicine
    private List<AgriBCMedicine> getBatchMedicines(AgriMedicineServiceImpl service,List<AgriMedicine> dbMedicines) throws GatewayException {
        List<AgriBCMedicine> results = new ArrayList<>();

        for( AgriMedicine Medicine : dbMedicines ){
            AgriBCMedicine bcMedicine = service.queryMedicine(Medicine.getMid());
            if (!Objects.isNull(bcMedicine)) {
                AgriTx tx = txService.selectAgriTxByPid(bcMedicine.getID());
                bcMedicine.setTxHash(tx.getTxid());
                bcMedicine.setTimeStamp(tx.getTimestamp());
                results.add(bcMedicine);
            }

        }
        return results;
    }

    //Routine
    private List<AgriBCRoutineCheck> getBatchRoutines(AgriRoutineServiceImpl service,List<AgriRoutine> dbRoutines) throws GatewayException {
        List<AgriBCRoutineCheck> results = new ArrayList<>();

        for( AgriRoutine Routine : dbRoutines ){
            AgriBCRoutineCheck bcRoutine = service.queryRoutineCheck(Routine.getRid());
            if (!Objects.isNull(bcRoutine)) {
                AgriTx tx = txService.selectAgriTxByPid(bcRoutine.getID());
                bcRoutine.setTxHash(tx.getTxid());
                bcRoutine.setTimeStamp(tx.getTimestamp());
                results.add(bcRoutine);
            }

        }
        return results;
    }

    // Sell
    private List<AgriBCSell> getBatchSells(AgriSellServiceImpl service,List<AgriSell> dbSells) throws GatewayException {
        List<AgriBCSell> results = new ArrayList<>();

        for( AgriSell Sell : dbSells ){
            AgriBCSell bcSell = service.querySell(Sell.getSid());
            if (!Objects.isNull(bcSell)) {
                AgriTx tx = txService.selectAgriTxByPid(bcSell.getID());
                bcSell.setTxHash(tx.getTxid());
                bcSell.setTimeStamp(tx.getTimestamp());
                results.add(bcSell);
            }

        }
        return results;
    }

    // Transport
    private List<AgriBCTransport> getBatchTransports(AgriTransportServiceImpl service,List<AgriTransport> dbTransports) throws GatewayException {
        List<AgriBCTransport> results = new ArrayList<>();

        for( AgriTransport Transport : dbTransports ){
            AgriBCTransport bcTransport = service.queryTransport(Transport.getTid());
            if (!Objects.isNull(bcTransport)) {
                AgriTx tx = txService.selectAgriTxByPid(bcTransport.getID());
                bcTransport.setTxHash(tx.getTxid());
                bcTransport.setTimeStamp(tx.getTimestamp());
                results.add(bcTransport);
            }

        }
        return results;
    }

    /*@GetMapping("/{id}")
    public AjaxResult mergeSearch( @PathVariable("id") String pid) throws GatewayException {

        List<AgriCheck> dbChecks = checkService.selectCheckByPid(pid);
        List<AgriFertilizer> dbFertilizers = fertilizerService.selectFertilizerByGid(pid);
        List<AgriMedicine> dbMedicines = medicineService.selectMedicineByGid(pid);
        List<AgriOfficial> dbOfficials = officialService.selectOfficialByPid(pid);
        List<AgriGrow> dbGrows = growService.selectGrowByPid(pid);
        List<AgriRoutine> dbRoutines = routineService.selectRoutineByPid(pid);
        List<AgriSell> dbSells = sellService.selectSellByPid(pid);
        List<AgriTransport> dbTransports = transportService.selectTransportByPid(pid);


//        从区块链上取数据
        AgriBCProduct bcProduct = productService.queryProduct(pid);
        AgriTx tx = txService.selectAgriTxByPid(bcProduct.getID());
        bcProduct.setTxHash(tx.getTxid());
        bcProduct.setTimeStamp(tx.getTimestamp());
        List<AgriBCCheck> batchChecks = getBatchChecks(checkService, dbChecks);
        List<AgriBCFertilizer> batchFertilizers = getBatchFertilizers(fertilizerService, dbFertilizers);
        List<AgriBCGrow> batchGrows = getBatchGrows(growService, dbGrows);
        List<AgriBCMedicine> batchMedicines = getBatchMedicines(medicineService, dbMedicines);
        List<AgriBCRoutineCheck> batchRoutines = getBatchRoutines(routineService, dbRoutines);
        List<AgriBCSell> batchSells = getBatchSells(sellService, dbSells);
        List<AgriBCTransport> batchTransports = getBatchTransports(transportService, dbTransports);
        List<AgriBCOfficialCheck> batchOfficialChecks = getBatchOfficialChecks(officialService, dbOfficials);

        AgriMergeResult result = new AgriMergeResult(bcProduct,batchChecks,batchFertilizers,batchGrows,batchMedicines,batchOfficialChecks,batchRoutines,batchSells,batchTransports);
        return AjaxResult.success(result);

    }*/
    @GetMapping("/{id}")
    public AjaxResult mergeSearch( @PathVariable("id") String pid) throws GatewayException {

        List<AgriCheck> dbChecks = checkService.selectCheckByPid(pid);

        // --- 核心修改开始：肥料查询兜底逻辑 ---
        // 1. 优先尝试按 GID (批次号) 查询
        List<AgriFertilizer> dbFertilizers = fertilizerService.selectFertilizerByGid(pid);
        // 2. 如果按 GID 查不到，尝试按 PID (产品号) 查询
        if (dbFertilizers == null || dbFertilizers.isEmpty()) {
            AgriFertilizer searchParam = new AgriFertilizer();
            searchParam.setPid(pid);
            dbFertilizers = fertilizerService.selectAgriFertilizerList(searchParam);
        }
        // --- 核心修改结束 ---

        // --- 核心修改开始：用药查询兜底逻辑 ---
        // 1. 优先尝试按 GID (批次号) 查询
        List<AgriMedicine> dbMedicines = medicineService.selectMedicineByGid(pid);
        // 2. 如果按 GID 查不到，尝试按 PID (产品号) 查询
        if (dbMedicines == null || dbMedicines.isEmpty()) {
            dbMedicines = medicineService.selectMedicineByPid(pid);
        }
        // --- 核心修改结束 ---

        List<AgriOfficial> dbOfficials = officialService.selectOfficialByPid(pid);
        List<AgriGrow> dbGrows = growService.selectGrowByPid(pid);
        List<AgriRoutine> dbRoutines = routineService.selectRoutineByPid(pid);
        List<AgriSell> dbSells = sellService.selectSellByPid(pid);
        List<AgriTransport> dbTransports = transportService.selectTransportByPid(pid);


//        从区块链上取数据
        AgriBCProduct bcProduct = productService.queryProduct(pid);
        if (bcProduct != null) {
            AgriTx tx = txService.selectAgriTxByPid(bcProduct.getID());
            if (tx != null) {
                bcProduct.setTxHash(tx.getTxid());
                bcProduct.setTimeStamp(tx.getTimestamp());
            }
        }

        List<AgriBCCheck> batchChecks = getBatchChecks(checkService, dbChecks);
        List<AgriBCFertilizer> batchFertilizers = getBatchFertilizers(fertilizerService, dbFertilizers);
        List<AgriBCGrow> batchGrows = getBatchGrows(growService, dbGrows);
        List<AgriBCMedicine> batchMedicines = getBatchMedicines(medicineService, dbMedicines);
        List<AgriBCRoutineCheck> batchRoutines = getBatchRoutines(routineService, dbRoutines);
        List<AgriBCSell> batchSells = getBatchSells(sellService, dbSells);
        List<AgriBCTransport> batchTransports = getBatchTransports(transportService, dbTransports);
        List<AgriBCOfficialCheck> batchOfficialChecks = getBatchOfficialChecks(officialService, dbOfficials);

        AgriMergeResult result = new AgriMergeResult(bcProduct,batchChecks,batchFertilizers,batchGrows,batchMedicines,batchOfficialChecks,batchRoutines,batchSells,batchTransports);
        return AjaxResult.success(result);

    }

    private String uploadServer(BufferedImage bufferedImage)
    {
        //将BufferedImage 转换为 MultipartFile 进行文件上传
        try
        {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage,"jpg",out);
            byte[] imageByte = out.toByteArray();
            MultipartFile file = new ConvertToMultipartFile(imageByte, IdUtils.simpleUUID(),IdUtils.fastSimpleUUID(), MimeTypeUtils.IMAGE_JPG,imageByte.length);
            // 上传文件路径
            String filePath = RuoYiConfig.getUploadPath();
            // 上传并返回新文件名称
            //file.getContentType() image/jpg
            String fileName = FileUploadUtils.upload(filePath, file);
            return fileName;
        }
        catch (IOException e)
        {
            return null;
        }
    }


//    生成二维码操作
    @PostMapping("/qtcode")
    public AjaxResult generateCode(@RequestBody String content) {
        BufferedImage bufferedImage = QRCodeUtils.createImage("utf-8", content,100, 100);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("url",uploadServer(bufferedImage));
        return ajax;
    }


}
