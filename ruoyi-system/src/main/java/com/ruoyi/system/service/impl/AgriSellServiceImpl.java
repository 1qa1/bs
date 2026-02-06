package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCSell;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriSellMapper;
import com.ruoyi.system.domain.AgriSell;
import com.ruoyi.system.service.IAgriSellService;

/**
 * 售卖信息IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriSellServiceImpl implements IAgriSellService 
{
    @Autowired
    private AgriSellMapper agriSellMapper;
    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;

    /**
     * 查询售卖信息ID
     * 
     * @param id 售卖信息ID主键
     * @return 售卖信息ID
     */
    @Override
    public AgriSell selectAgriSellById(Long id)
    {
        return agriSellMapper.selectAgriSellById(id);
    }

    @Override
    public void deleteSellByPid(String pid) {
        agriSellMapper.deleteSellByPid(pid);
    }

    /**
     * 查询售卖信息ID列表
     * 
     * @param agriSell 售卖信息ID
     * @return 售卖信息ID
     */
    @Override
    public List<AgriSell> selectAgriSellList(AgriSell agriSell)
    {
        return agriSellMapper.selectAgriSellList(agriSell);
    }

    /**
     * 新增售卖信息ID
     * 
     * @param agriSell 售卖信息ID
     * @return 结果
     */
    @Override
    public int insertAgriSell(AgriSell agriSell)
    {
        return agriSellMapper.insertAgriSell(agriSell);
    }

    /**
     * 修改售卖信息ID
     * 
     * @param agriSell 售卖信息ID
     * @return 结果
     */
    @Override
    public int updateAgriSell(AgriSell agriSell)
    {
        return agriSellMapper.updateAgriSell(agriSell);
    }

    /**
     * 批量删除售卖信息ID
     * 
     * @param ids 需要删除的售卖信息ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriSellByIds(Long[] ids)
    {
        return agriSellMapper.deleteAgriSellByIds(ids);
    }

    /**
     * 删除售卖信息ID信息
     * 
     * @param id 售卖信息ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriSellById(Long id)
    {
        return agriSellMapper.deleteAgriSellById(id);
    }

    @Override
    public List<AgriSell> selectSellByPid(String pid) {
        return agriSellMapper.selectSellByPid(pid);
    }

    @Override
    public AgriSell selectSellBySid(String sid) {
        return agriSellMapper.selectSellBySid(sid);
    }

    @Override
    public int submitSell(AgriBCSell Sell) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCSell(Sell);
    }

    @Override
    public int deleteSell(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCSell(id);
    }

    @Override
    public int updateSell(AgriBCSell Sell) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCSell(Sell);
    }

    @Override
    public AgriBCSell querySell(String id)  {

        try {
            return query.queryAgriBCSell(id);
        } catch (GatewayException e) {
            return null;
        }
    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
