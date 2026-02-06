package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCOfficialCheck;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriOfficialMapper;
import com.ruoyi.system.domain.AgriOfficial;
import com.ruoyi.system.service.IAgriOfficialService;

/**
 * 官方抽查Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriOfficialServiceImpl implements IAgriOfficialService 
{
    @Autowired
    private AgriOfficialMapper agriOfficialMapper;

    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;
    /**
     * 查询官方抽查
     * 
     * @param id 官方抽查主键
     * @return 官方抽查
     */
    @Override
    public AgriOfficial selectAgriOfficialById(Long id)
    {
        return agriOfficialMapper.selectAgriOfficialById(id);
    }

    @Override
    public void deleteOfficialByPid(String pid) {
        agriOfficialMapper.deleteOfficialByPid(pid);
    }

    /**
     * 查询官方抽查列表
     * 
     * @param agriOfficial 官方抽查
     * @return 官方抽查
     */
    @Override
    public List<AgriOfficial> selectAgriOfficialList(AgriOfficial agriOfficial)
    {
        return agriOfficialMapper.selectAgriOfficialList(agriOfficial);
    }

    /**
     * 新增官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    @Override
    public int insertAgriOfficial(AgriOfficial agriOfficial)
    {
        return agriOfficialMapper.insertAgriOfficial(agriOfficial);
    }

    /**
     * 修改官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    @Override
    public int updateAgriOfficial(AgriOfficial agriOfficial)
    {
        return agriOfficialMapper.updateAgriOfficial(agriOfficial);
    }

    /**
     * 批量删除官方抽查
     * 
     * @param ids 需要删除的官方抽查主键
     * @return 结果
     */
    @Override
    public int deleteAgriOfficialByIds(Long[] ids)
    {
        return agriOfficialMapper.deleteAgriOfficialByIds(ids);
    }

    /**
     * 删除官方抽查信息
     * 
     * @param id 官方抽查主键
     * @return 结果
     */
    @Override
    public int deleteAgriOfficialById(Long id)
    {
        return agriOfficialMapper.deleteAgriOfficialById(id);
    }

    @Override
    public List<AgriOfficial> selectOfficialByPid(String pid) {
        return agriOfficialMapper.selectOfficialByPid(pid);
    }

    @Override
    public AgriOfficial selectOfficialByOid(String oid) {
        return agriOfficialMapper.selectOfficialByOid(oid);
    }

    @Override
    public int submitOfficial(AgriBCOfficialCheck Official) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCOfficial(Official);
    }

    @Override
    public int deleteOfficial(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCOfficialCheck(id);
    }

    @Override
    public int updateOfficial(AgriBCOfficialCheck Official) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCOfficial(Official);
    }

    @Override
    public AgriBCOfficialCheck queryOfficial(String id)  {
        try {
            AgriBCOfficialCheck bcOfficialCheck = query.queryAgriBCOfficialCheck(id);
            return bcOfficialCheck;
        }catch (GatewayException e ){
            return null;
        }
    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
