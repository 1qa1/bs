package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.*;
import org.hyperledger.fabric.client.*;

/**
 * 产品IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriProductService 
{
    /**
     * 查询产品ID
     * 
     * @param id 产品ID主键
     * @return 产品ID
     */
    public AgriProduct selectAgriProductById(Long id);

    /**
     * 查询产品ID列表
     * 
     * @param agriProduct 产品ID
     * @return 产品ID集合
     */
    public List<AgriProduct> selectAgriProductList(AgriProduct agriProduct);

    /**
     * 新增产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    public int insertAgriProduct(AgriProduct agriProduct);

    /**
     * 修改产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    public int updateAgriProduct(AgriProduct agriProduct);

    /**
     * 批量删除产品ID
     * 
     * @param ids 需要删除的产品ID主键集合
     * @return 结果
     */
    public int deleteAgriProductByIds(Long[] ids);

    /**
     * 删除产品ID信息
     * 
     * @param id 产品ID主键
     * @return 结果
     */
    public int deleteAgriProductById(Long id);

    public AgriProduct selectProductByPid(String pid);

    //     *** blockchain ***
//    add
    public int submitProduct(AgriBCProduct Product) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteProduct( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateProduct(AgriBCProduct Product) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCProduct queryProduct( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;

}
