package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCCheck;
import com.ruoyi.system.domain.AgriCheck;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 商品检查IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriCheckService 
{
    /**
     * 查询商品检查ID
     * 
     * @param id 商品检查ID主键
     * @return 商品检查ID
     */
    public AgriCheck selectAgriCheckById(Long id);
    public void deleteCheckByPid( String pid);

    /**
     * 查询商品检查ID列表
     * 
     * @param agriCheck 商品检查ID
     * @return 商品检查ID集合
     */
    public List<AgriCheck> selectAgriCheckList(AgriCheck agriCheck);

    /**
     * 新增商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    public int insertAgriCheck(AgriCheck agriCheck);

    /**
     * 修改商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    public int updateAgriCheck(AgriCheck agriCheck);

    /**
     * 批量删除商品检查ID
     * 
     * @param ids 需要删除的商品检查ID主键集合
     * @return 结果
     */
    public int deleteAgriCheckByIds(Long[] ids);

    /**
     * 删除商品检查ID信息
     * 
     * @param id 商品检查ID主键
     * @return 结果
     */
    public int deleteAgriCheckById(Long id);
    
    /**
     * 根据pid查询check
     * 
 * @param pid
     * @return com.ruoyi.system.domain.AgriCheck
     * @author sun
     * @create 2022/12/26
     **/
    
    public List<AgriCheck> selectCheckByPid( String pid);
    public AgriCheck selectCheckByCid( String cid );

//     *** blockchain ***
//    add
    public int submitCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException;
//    delete
    public int deleteCheck( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
//    update
    public int updateCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException;
//    query
    public AgriBCCheck queryCheck( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
    
}
