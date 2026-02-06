package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCRoutineCheck;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriRoutineMapper;
import com.ruoyi.system.domain.AgriRoutine;
import com.ruoyi.system.service.IAgriRoutineService;

/**
 * 日常抽查Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriRoutineServiceImpl implements IAgriRoutineService 
{
    @Autowired
    private AgriRoutineMapper agriRoutineMapper;
    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;

    /**
     * 查询日常抽查
     * 
     * @param id 日常抽查主键
     * @return 日常抽查
     */
    @Override
    public AgriRoutine selectAgriRoutineById(Long id)
    {
        return agriRoutineMapper.selectAgriRoutineById(id);
    }

    @Override
    public void deleteRoutineByPid(String pid) {
        agriRoutineMapper.deleteRoutineByPid(pid);
    }

    /**
     * 查询日常抽查列表
     * 
     * @param agriRoutine 日常抽查
     * @return 日常抽查
     */
    @Override
    public List<AgriRoutine> selectAgriRoutineList(AgriRoutine agriRoutine)
    {
        return agriRoutineMapper.selectAgriRoutineList(agriRoutine);
    }

    /**
     * 新增日常抽查
     * 
     * @param agriRoutine 日常抽查
     * @return 结果
     */
    @Override
    public int insertAgriRoutine(AgriRoutine agriRoutine)
    {
        return agriRoutineMapper.insertAgriRoutine(agriRoutine);
    }

    /**
     * 修改日常抽查
     * 
     * @param agriRoutine 日常抽查
     * @return 结果
     */
    @Override
    public int updateAgriRoutine(AgriRoutine agriRoutine)
    {
        return agriRoutineMapper.updateAgriRoutine(agriRoutine);
    }

    /**
     * 批量删除日常抽查
     * 
     * @param ids 需要删除的日常抽查主键
     * @return 结果
     */
    @Override
    public int deleteAgriRoutineByIds(Long[] ids)
    {
        return agriRoutineMapper.deleteAgriRoutineByIds(ids);
    }

    /**
     * 删除日常抽查信息
     * 
     * @param id 日常抽查主键
     * @return 结果
     */
    @Override
    public int deleteAgriRoutineById(Long id)
    {
        return agriRoutineMapper.deleteAgriRoutineById(id);
    }

    @Override
    public List<AgriRoutine> selectRoutineByPid(String pid) {
        return agriRoutineMapper.selectRoutineByPid(pid);
    }

    @Override
    public AgriRoutine selectRoutineByRid(String rid) {
        return agriRoutineMapper.selectRoutineByRid(rid);
    }

    @Override
    public int submitRoutineCheck(AgriBCRoutineCheck RoutineCheck) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCRoutine(RoutineCheck);
    }

    @Override
    public int deleteRoutineCheck(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCRoutineCheck(id);
    }

    @Override
    public int updateRoutineCheck(AgriBCRoutineCheck RoutineCheck) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCRoutine(RoutineCheck);
    }

    @Override
    public AgriBCRoutineCheck queryRoutineCheck(String id) {
        try{
            AgriBCRoutineCheck agriBCRoutineCheck = query.queryAgriBCRoutineCheck(id);
            return agriBCRoutineCheck;
        } catch (GatewayException e) {
            return null;
        }

    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
