package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCOfficialCheck;
import com.ruoyi.system.domain.AgriOfficial;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 官方抽查Service接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriOfficialService 
{
    /**
     * 查询官方抽查
     * 
     * @param id 官方抽查主键
     * @return 官方抽查
     */
    public AgriOfficial selectAgriOfficialById(Long id);

    public void deleteOfficialByPid( String pid);

    /**
     * 查询官方抽查列表
     * 
     * @param agriOfficial 官方抽查
     * @return 官方抽查集合
     */
    public List<AgriOfficial> selectAgriOfficialList(AgriOfficial agriOfficial);

    /**
     * 新增官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    public int insertAgriOfficial(AgriOfficial agriOfficial);

    /**
     * 修改官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    public int updateAgriOfficial(AgriOfficial agriOfficial);

    /**
     * 批量删除官方抽查
     * 
     * @param ids 需要删除的官方抽查主键集合
     * @return 结果
     */
    public int deleteAgriOfficialByIds(Long[] ids);

    /**
     * 删除官方抽查信息
     * 
     * @param id 官方抽查主键
     * @return 结果
     */
    public int deleteAgriOfficialById(Long id);

    /**
     *  根据pid查询到官方查验信息
     *
     * @param pid
     * @return com.ruoyi.system.domain.AgriOfficial
     * @author sun
     * @create 2022/12/26
     **/

    public List<AgriOfficial> selectOfficialByPid( String pid);
    public AgriOfficial selectOfficialByOid( String oid);
    //     *** blockchain ***
//    add
    public int submitOfficial(AgriBCOfficialCheck Official) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteOfficial( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateOfficial(AgriBCOfficialCheck Official) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCOfficialCheck queryOfficial( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
    
}
