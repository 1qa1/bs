package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.*;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriGrowMapper;
import com.ruoyi.system.service.IAgriGrowService;

/**
 * 种植ID管理Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriGrowServiceImpl implements IAgriGrowService
{
    @Autowired
    private AgriGrowMapper agriGrowMapper;

    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;

    /**
     * 查询种植ID管理
     * 
     * @param id 种植ID管理主键
     * @return 种植ID管理
     */
    @Override
    public AgriGrow selectAgriGrowById(Long id)
    {
        return agriGrowMapper.selectAgriGrowById(id);
    }

    @Override
    public void deleteGrowByPid(String pid) {
        agriGrowMapper.deleteGrowByPid(pid);
    }

    /**
     * 查询种植ID管理列表
     * 
     * @param agriGrow 种植ID管理
     * @return 种植ID管理
     */
    @Override
    public List<AgriGrow> selectAgriGrowList(AgriGrow agriGrow)
    {
        return agriGrowMapper.selectAgriGrowList(agriGrow);
    }

    /**
     * 新增种植ID管理
     * 
     * @param agriGrow 种植ID管理
     * @return 结果
     */
    @Override
    public int insertAgriGrow(AgriGrow agriGrow)
    {
        return agriGrowMapper.insertAgriGrow(agriGrow);
    }

    /**
     * 修改种植ID管理
     * 
     * @param agriGrow 种植ID管理
     * @return 结果
     */
    @Override
    public int updateAgriGrow(AgriGrow agriGrow)
    {
        return agriGrowMapper.updateAgriGrow(agriGrow);
    }

    /**
     * 批量删除种植ID管理
     * 
     * @param ids 需要删除的种植ID管理主键
     * @return 结果
     */
    @Override
    public int deleteAgriGrowByIds(Long[] ids)
    {
        return agriGrowMapper.deleteAgriGrowByIds(ids);
    }

    /**
     * 删除种植ID管理信息
     * 
     * @param id 种植ID管理主键
     * @return 结果
     */
    @Override
    public int deleteAgriGrowById(Long id)
    {
        return agriGrowMapper.deleteAgriGrowById(id);
    }

    @Override
    public List<AgriGrow> selectGrowByPid(String pid) {
        return agriGrowMapper.selectGrowByPid(pid);
    }

    @Override
    public AgriGrow selectGrowByGid(String gid) {
        return agriGrowMapper.selectGrowByGid(gid);
    }

    @Override
    public int submitGrow(AgriBCGrow grow) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCGrow(grow);
    }

    @Override
    public int deleteGrow(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCGrow(id);
    }

    @Override
    public int updateGrow(AgriBCGrow grow) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCGrow(grow);
    }

    @Override
    public AgriBCGrow queryGrow(String id)  {
        try {
            AgriBCGrow grow = query.queryAgriBCGrow(id);
            return grow;
        } catch (GatewayException e) {
            return null;
        }

    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }


}
