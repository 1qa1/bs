package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCTransport;
import com.ruoyi.system.domain.AgriTransport;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 运输信息IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriTransportService 
{
    /**
     * 查询运输信息ID
     * 
     * @param id 运输信息ID主键
     * @return 运输信息ID
     */
    public AgriTransport selectAgriTransportById(Long id);

    public void deleteTransportByPid( String pid);

    /**
     * 查询运输信息ID列表
     * 
     * @param agriTransport 运输信息ID
     * @return 运输信息ID集合
     */
    public List<AgriTransport> selectAgriTransportList(AgriTransport agriTransport);

    /**
     * 新增运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    public int insertAgriTransport(AgriTransport agriTransport);

    /**
     * 修改运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    public int updateAgriTransport(AgriTransport agriTransport);

    /**
     * 批量删除运输信息ID
     * 
     * @param ids 需要删除的运输信息ID主键集合
     * @return 结果
     */
    public int deleteAgriTransportByIds(Long[] ids);

    /**
     * 删除运输信息ID信息
     * 
     * @param id 运输信息ID主键
     * @return 结果
     */
    public int deleteAgriTransportById(Long id);
    
    /**
     *  根据pid查询到运输信息
     * 
 * @param pid
     * @return com.ruoyi.system.domain.AgriTransport
     * @author sun
     * @create 2022/12/26
     **/
    
    public List<AgriTransport> selectTransportByPid( String pid);
    public AgriTransport selectTransportByTid( String tid);
    //     *** blockchain ***
//    add
    public int submitTransport(AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteTransport( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateTransport(AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCTransport queryTransport( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
