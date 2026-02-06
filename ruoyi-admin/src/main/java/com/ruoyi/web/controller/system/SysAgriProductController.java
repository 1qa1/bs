package com.ruoyi.web.controller.system;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.AgriBCProduct;
import com.ruoyi.system.domain.AgriProduct;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.impl.*;
import com.ruoyi.system.utils.GenerateUUID;
//import lombok.extern.slf4j.Slf4j;
import lombok.extern.slf4j.Slf4j;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture; // 引入异步处理包

/**
 * 产品管理 Controller
 * 集成异步上链与失败状态处理
 *
 **/
@Slf4j
@RestController
@RequestMapping("/system/product/")
public class SysAgriProductController extends BaseController {
    @Autowired
    private AgriProductServiceImpl service;

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
    private AgriRoutineServiceImpl routineService;

    @Autowired
    private AgriSellServiceImpl sellService;

    @Autowired
    private AgriTransportServiceImpl transportService;

    @Autowired
    private AgriTxServiceImpl txService;
    //     增加

    /*public AjaxResult addProduct(@RequestBody AgriBCProduct Product) throws GatewayException, CommitException {
//        生成uid 并设置
        Product.setID(GenerateUUID.Generate());
        //创建一个新的 AgriProduct 对象，用于存储产品在本地数据库中的基本信息
        AgriProduct dbProduct = new AgriProduct(Product.getID(),Product.getProductName());
        //将该对象插入到数据库中
        service.insertAgriProduct(dbProduct);
        //将完整的 AgriBCProduct 对象提交到 Hyperledger Fabric 区块链网络
        service.submitProduct(Product);

        //新增 tx ，保存每个数据的上链hash，将查询到的交易信息封装成 AgriTx 对象，并设置其关联的产品 ID
        AgriTx tx = service.queryTxHash();
        tx.setPid(Product.getID());
        //将交易信息保存到本地数据库中，以便后续追溯。
        txService.insertAgriTx(tx);


        return AjaxResult.success("新增成功");
    }*/
    @PostMapping("/")
    public AjaxResult addProduct(@RequestBody AgriProduct product) throws GatewayException, CommitException {
        // 生成系统内部/区块链用的 UUID (pid)
        product.setPid(GenerateUUID.Generate());
        // 设置初始状态为 0 (处理中/未上链)
        product.setStatus(0);
        // 先存入 MySQL，确保本地有数据，让用户立刻看到
        service.insertAgriProduct(product);

        // 【核心优化】开启异步线程处理上链逻辑
        CompletableFuture.runAsync(() -> {
            try {
                // --- 准备上链数据 ---
                AgriBCProduct bcProduct = new AgriBCProduct();
                bcProduct.setID(product.getPid());
                // 处理空值，防止空指针
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
                } catch (NumberFormatException e) {
                    bcProduct.setNumber(0);
                }

                // --- 执行耗时的上链操作 ---
                // 即使这里耗时超过 60秒，也不会影响前端，只会在后台日志报错
                service.submitProduct(bcProduct);

                // --- 获取交易信息 ---
                AgriTx tx = service.queryTxHash();

                // --- 上链成功，回写数据库 ---
                product.setTxHash(tx.getTxid());
                product.setTimeStamp(tx.getTimestamp());
                product.setStatus(1); // 1 表示已上链成功
                service.updateAgriProduct(product);

                // --- 备份交易记录 ---
                tx.setPid(product.getPid());
                txService.insertAgriTx(tx);

                log.info("产品 {} 异步上链成功，Hash: {}", product.getName(), tx.getTxid());

            } catch (Exception e) {
                log.error("产品 {} 异步上链失败", product.getName(), e);

                // 【失败处理】将状态改为 2 (上链失败)
                // 这样前端可以看到状态异常，或者定时任务可以扫描 status=2 的数据进行重试
                product.setStatus(2);
                service.updateAgriProduct(product);
            }
        });

        // 5. 不等待上链结果，直接返回成功
        return AjaxResult.success("新增成功，数据正在后台上链...");
    }

    /*public AjaxResult updateProduct( @RequestBody AgriBCProduct Product) throws GatewayException, CommitException {
//         1. 查询出相应的Product
        AgriProduct dbProduct = service.selectProductByPid(Product.getID());
//        2. 修改相应的pid
        dbProduct.setPid(Product.getID());
//        3. 更新数据库
        service.updateAgriProduct(dbProduct);
//        4. 更新fabric
        service.updateProduct(Product);

        AgriTx tx = service.queryTxHash();
        tx.setPid(Product.getID());
        txService.updateAgriTx(tx);

        return AjaxResult.success("更新成功");
    }*/
    @PutMapping("/")
    public AjaxResult updateProduct(@RequestBody AgriProduct product) throws GatewayException, CommitException {
        // 1. 更新数据库
        service.updateAgriProduct(product);
        // 2. 异步处理链上更新
        CompletableFuture.runAsync(() -> {
            try {
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
                } catch (NumberFormatException e) {
                    bcProduct.setNumber(0);
                }

                // 耗时操作
                service.updateProduct(bcProduct);

                // 更新交易记录
                AgriTx tx = service.queryTxHash();
                tx.setPid(product.getPid());

                // 更新数据库里的 Hash
                product.setTxHash(tx.getTxid());
                product.setTimeStamp(tx.getTimestamp());
                // 如果之前是失败状态，修改成功后改为成功
                product.setStatus(1);
                service.updateAgriProduct(product);

                txService.updateAgriTx(tx);
                log.info("产品 {} 更新上链成功", product.getName());

            } catch (Exception e) {
                log.error("产品 {} 更新上链失败", product.getName(), e);
                // 更新失败一般不需要改状态为失败，保持原样或记录日志即可，视业务需求而定
            }
        });

        return AjaxResult.success("更新提交成功，正在同步至区块链...");
    }

    /*public AjaxResult deleteProduct( @PathVariable("ids") String[] pids ) throws EndorseException, CommitException, SubmitException, CommitStatusException {

        for( String pid : pids ){
            //        1. 删除区块链上的信息
            service.deleteProduct(pid);
            //        2. 删除数据库关系
            AgriProduct dbProduct = service.selectProductByPid(pid);
//            3. 删除产品以及产品的关系
            clearRelationShip(dbProduct);
            txService.deleteAgriTxByPid(pid);
        }
        return AjaxResult.success("删除成功");
    }*/
    //    删除
    @DeleteMapping("/{ids}")
    public AjaxResult deleteProduct(@PathVariable("ids") Long[] ids) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        for (Long id : ids) {
            // 1. 先根据数据库 ID 查出产品对象
            AgriProduct dbProduct = service.selectAgriProductById(id);

            // 2. 判空处理：如果查不到数据，跳过，防止空指针异常
            if (dbProduct != null) {
                String pid = dbProduct.getPid();

                // 3. 删除区块链上的信息 (如果 pid 存在)
                if (pid != null && !pid.isEmpty()) {
                    try {
                        service.deleteProduct(pid);
                    } catch (Exception e) {
                        // 记录日志，但不阻断后续数据库删除
                        log.error("区块链数据删除失败，PID: " + pid, e);
                    }
                    // 4. 删除交易记录
                    txService.deleteAgriTxByPid(pid);
                }

                // 5. 删除数据库中的产品及关联信息
                clearRelationShip(dbProduct);
            }
        }
        return AjaxResult.success("删除成功");
    }
    /*public AjaxResult deleteProduct(@PathVariable("ids") Long[] ids) {
        for (Long id : ids) {
            // 1. 先根据数据库 ID 查出产品对象
            AgriProduct dbProduct = service.selectAgriProductById(id);

            // 2. 判空处理
            if (dbProduct != null) {
                String pid = dbProduct.getPid();

                // 3. 删除数据库中的产品及关联信息 (让用户立刻看不到数据)
                clearRelationShip(dbProduct);

                // 4. 异步删除区块链上的信息
                if (pid != null && !pid.isEmpty()) {
                    CompletableFuture.runAsync(() -> {
                        try {
                            service.deleteProduct(pid);
                            txService.deleteAgriTxByPid(pid);
                            log.info("PID {} 链上数据删除成功", pid);
                        } catch (Exception e) {
                            log.error("PID {} 链上数据删除失败", pid, e);
                        }
                    });
                }
            }
        }
        return AjaxResult.success("删除成功");
    }*/


    /*public AjaxResult listProduct() throws GatewayException {
//        查询所有的cid  根据pid
        List<AgriProduct> dbProducts = service.selectAgriProductList(null);
        List<AgriBCProduct> results = new ArrayList<>();
        for ( AgriProduct Product : dbProducts) {
            AgriBCProduct bcProduct = service.queryProduct(Product.getPid());
//            如果不存在
            if (Objects.isNull(bcProduct) ) {
//                清空和product相关的一切
                clearRelationShip(Product);
            }else {
                AgriTx tx = txService.selectAgriTxByPid(Product.getPid());
                bcProduct.setTxHash(tx.getTxid());
                bcProduct.setTimeStamp(tx.getTimestamp());
                results.add(bcProduct);
            }
        }
        return AjaxResult.success(results);
    }*/
    //    查询
    @GetMapping("/")
    public TableDataInfo listProduct(AgriProduct product) {
        // 1. 设置分页参数 (BaseController 提供的方法，会自动读取前端传来的 pageNum 和 pageSize)
        startPage();
        // 2. 查询数据库列表
        List<AgriProduct> list = service.selectAgriProductList(product);
        // 3. 响应请求分页数据 (BaseController 提供的方法，会自动封装成 {total: x, rows: [...]})
        return getDataTable(list);
    }


    /*public AjaxResult getProduct( @PathVariable("id") String  pid ) {
        AgriBCProduct bcProduct = service.queryProduct(pid);
        AgriTx tx = txService.selectAgriTxByPid(pid);
        bcProduct.setTxHash(tx.getTxid());
        bcProduct.setTimeStamp(tx.getTimestamp());
        return AjaxResult.success(bcProduct);
    }*/
    //    单个查询
    @GetMapping("/{id}")
    public AjaxResult getProduct(@PathVariable("id") Long id) {
        // 1. 先查数据库，获取完整信息 (包含 name, number, tp 等)
        AgriProduct product = service.selectAgriProductById(id);
        if (product != null) {
            // 2. (可选) 如果需要区块链上的最新状态，可以再去查链
            // AgriBCProduct bcProduct = service.queryProduct(product.getPid());
            // 这里直接返回数据库里的 product 即可，因为我们现在做了读写分离，数据库里是最新的
            return AjaxResult.success(product);
        } else {
            return AjaxResult.error("未找到对应产品");
        }
    }

    @PostMapping("/export")
    public void export(HttpServletResponse response, AgriBCProduct product)
    {
        List<AgriProduct> dbProducts = service.selectAgriProductList(null);
        List<AgriBCProduct> results = new ArrayList<>();
        for ( AgriProduct Product : dbProducts) {
            AgriBCProduct bcProduct = service.queryProduct(Product.getPid());
//            如果不存在
            if (Objects.isNull(bcProduct) ) {
//                清空和product相关的一切
                clearRelationShip(Product);
            }else {
                AgriTx tx = txService.selectAgriTxByPid(bcProduct.getID());
                bcProduct.setTxHash(tx.getTxid());
                bcProduct.setTimeStamp(tx.getTimestamp());
                results.add(bcProduct);
            }
        }
        ExcelUtil<AgriBCProduct> util = new ExcelUtil<>(AgriBCProduct.class);
        util.exportExcel(response, results, "产品数据");
    }

//    商品名发起搜素
    @GetMapping("/top/{name}")
    public AjaxResult searchForName( @PathVariable("name") String name){
        List<AgriProduct> dbProducts = service.selectAgriProductList(null);
        AgriProduct res = null;
        for( AgriProduct product : dbProducts ) {
            if ( product.getName().equals(name)) {
                res = product;
                break;
            }
        }
        /*AgriBCProduct bcProduct = service.queryProduct(res.getPid());
        AgriTx tx = txService.selectAgriTxByPid(bcProduct.getID());
        bcProduct.setTxHash(tx.getTxid());
        bcProduct.setTimeStamp(tx.getTimestamp());
        return AjaxResult.success(bcProduct);*/
        if (res == null) return AjaxResult.error("未找到商品");
        AgriBCProduct bcProduct = service.queryProduct(res.getPid());
        if (bcProduct != null) {
            AgriTx tx = txService.selectAgriTxByPid(bcProduct.getID());
            if (tx != null) {
                bcProduct.setTxHash(tx.getTxid());
                bcProduct.setTimeStamp(tx.getTimestamp());
            }
            return AjaxResult.success(bcProduct);
        }
        return AjaxResult.error("链上未找到该商品");

    }

    private void clearRelationShip(AgriProduct product) {
        String pid = product.getPid();
        service.deleteAgriProductById(product.getId());
        checkService.deleteCheckByPid(pid);
        fertilizerService.deleteFertilizerByGid(pid);
        growService.deleteGrowByPid(pid);
        medicineService.deleteMedicineByGid(pid);
        officialService.deleteOfficialByPid(pid);
        routineService.deleteRoutineByPid(pid);
        sellService.deleteSellByPid(pid);
        transportService.deleteTransportByPid(pid);
    }

}
