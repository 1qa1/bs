package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCTransport;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriTransportMapper;
import com.ruoyi.system.domain.AgriTransport;
import com.ruoyi.system.service.IAgriTransportService;

/**
 * 运输信息IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriTransportServiceImpl implements IAgriTransportService 
{
    @Autowired
    private AgriTransportMapper agriTransportMapper;
    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;

    /**
     * 查询运输信息ID
     * 
     * @param id 运输信息ID主键
     * @return 运输信息ID
     */
    @Override
    public AgriTransport selectAgriTransportById(Long id)
    {
        return agriTransportMapper.selectAgriTransportById(id);
    }

    @Override
    public void deleteTransportByPid(String pid) {
        agriTransportMapper.deleteTransportByPid(pid);
    }

    /**
     * 查询运输信息ID列表
     * 
     * @param agriTransport 运输信息ID
     * @return 运输信息ID
     */
    @Override
    public List<AgriTransport> selectAgriTransportList(AgriTransport agriTransport)
    {
        return agriTransportMapper.selectAgriTransportList(agriTransport);
    }

    /**
     * 新增运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    @Override
    public int insertAgriTransport(AgriTransport agriTransport)
    {
        return agriTransportMapper.insertAgriTransport(agriTransport);
    }

    /**
     * 修改运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    @Override
    public int updateAgriTransport(AgriTransport agriTransport)
    {
        return agriTransportMapper.updateAgriTransport(agriTransport);
    }

    /**
     * 批量删除运输信息ID
     * 
     * @param ids 需要删除的运输信息ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriTransportByIds(Long[] ids)
    {
        return agriTransportMapper.deleteAgriTransportByIds(ids);
    }

    /**
     * 删除运输信息ID信息
     * 
     * @param id 运输信息ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriTransportById(Long id)
    {
        return agriTransportMapper.deleteAgriTransportById(id);
    }

    @Override
    public List<AgriTransport> selectTransportByPid(String pid) {
        return agriTransportMapper.selectTransportByPid(pid);
    }

    @Override
    public AgriTransport selectTransportByTid(String tid) {
        return agriTransportMapper.selectTransportByTid(tid);
    }

    @Override
    public int submitTransport(AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCTransportation(transport);
    }

    @Override
    public int deleteTransport(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCTransport(id);
    }

    @Override
    public int updateTransport(AgriBCTransport transport) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCTransportation(transport);
    }

    @Override
    public AgriBCTransport queryTransport(String id)  {
        try {
            return query.queryAgriBCTransport(id);
        } catch (GatewayException e) {
            return null;
        }
    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
