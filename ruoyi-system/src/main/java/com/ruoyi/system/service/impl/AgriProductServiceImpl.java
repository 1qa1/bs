package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.*;
import lombok.extern.slf4j.Slf4j;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriProductMapper;
import com.ruoyi.system.service.IAgriProductService;

/**
 * 产品IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
@Slf4j
public class AgriProductServiceImpl implements IAgriProductService 
{
    @Autowired
    private AgriProductMapper agriProductMapper;
    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;


    /**
     * 查询产品ID
     * 
     * @param id 产品ID主键
     * @return 产品ID
     */
    @Override
    public AgriProduct selectAgriProductById(Long id)
    {
        return agriProductMapper.selectAgriProductById(id);
    }

    /**
     * 查询产品ID列表
     * 
     * @param agriProduct 产品ID
     * @return 产品ID
     */
    @Override
    public List<AgriProduct> selectAgriProductList(AgriProduct agriProduct)
    {
        return agriProductMapper.selectAgriProductList(agriProduct);
    }

    /**
     * 新增产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    @Override
    public int insertAgriProduct(AgriProduct agriProduct)
    {
        return agriProductMapper.insertAgriProduct(agriProduct);
    }

    /**
     * 修改产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    @Override
    public int updateAgriProduct(AgriProduct agriProduct)
    {
        return agriProductMapper.updateAgriProduct(agriProduct);
    }

    /**
     * 批量删除产品ID
     * 
     * @param ids 需要删除的产品ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriProductByIds(Long[] ids)
    {
        return agriProductMapper.deleteAgriProductByIds(ids);
    }

    /**
     * 删除产品ID信息
     * 
     * @param id 产品ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriProductById(Long id)
    {
        return agriProductMapper.deleteAgriProductById(id);
    }



    public AgriProduct selectProductByPid(String pid) {
        return agriProductMapper.selectProductByPid(pid);
    }

    @Override
    /*public int submitProduct(AgriBCProduct Product) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCProduct(Product);
    }*/
    public int submitProduct(AgriBCProduct Product) {
        try {
            return submit.insertAgriBCProduct(Product);
        } catch (Exception e) {
            log.error("数据上链失败", e);
            throw new ServiceException("数据上链失败: " + e.getMessage());
        }
    }

    @Override
    public int deleteProduct(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCProduct(id);
    }

    @Override
    public int updateProduct(AgriBCProduct Product) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCProduct(Product);
    }

    @Override
    /*public AgriBCProduct queryProduct(String id) {
        AgriBCProduct bcProduct = null;
        try {
            bcProduct = query.queryAgriBCProduct(id);
        }catch (GatewayException e ) {
            log.info("id" + id + " has not exists!");
        }
        return bcProduct;
    }*/
    public AgriBCProduct queryProduct(String id) {
        try {
            return query.queryAgriBCProduct(id);
        } catch (GatewayException e) {
            log.warn("区块链查询失败或ID不存在: {}", id);
            // 选项 A: 返回 null (Controller 必须检查)
            //return null;
            // 选项 B: 抛出若依的业务异常 (推荐)
            throw new ServiceException("链上数据不存在: " + id);
        }
    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
