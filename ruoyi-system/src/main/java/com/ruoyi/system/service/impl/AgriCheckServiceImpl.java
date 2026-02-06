package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCCheck;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriCheckMapper;
import com.ruoyi.system.domain.AgriCheck;
import com.ruoyi.system.service.IAgriCheckService;

/**
 * 商品检查IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriCheckServiceImpl implements IAgriCheckService 
{
    @Autowired
    private AgriCheckMapper agriCheckMapper;

    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;


    /**
     * 查询商品检查ID
     * 
     * @param id 商品检查ID主键
     * @return 商品检查ID
     */
    @Override
    public AgriCheck selectAgriCheckById(Long id)
    {
        return agriCheckMapper.selectAgriCheckById(id);
    }

    @Override
    public void deleteCheckByPid(String pid) {
        agriCheckMapper.deleteCheckByPid(pid);
    }

    /**
     * 查询商品检查ID列表
     * 
     * @param agriCheck 商品检查ID
     * @return 商品检查ID
     */
    @Override
    public List<AgriCheck> selectAgriCheckList(AgriCheck agriCheck)
    {
        return agriCheckMapper.selectAgriCheckList(agriCheck);
    }

    /**
     * 新增商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    @Override
    public int insertAgriCheck(AgriCheck agriCheck)
    {
        return agriCheckMapper.insertAgriCheck(agriCheck);
    }

    /**
     * 修改商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    @Override
    public int updateAgriCheck(AgriCheck agriCheck)
    {
        return agriCheckMapper.updateAgriCheck(agriCheck);
    }

    /**
     * 批量删除商品检查ID
     * 
     * @param ids 需要删除的商品检查ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriCheckByIds(Long[] ids)
    {
        return agriCheckMapper.deleteAgriCheckByIds(ids);
    }

    /**
     * 删除商品检查ID信息
     * 
     * @param id 商品检查ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriCheckById(Long id)
    {
        return agriCheckMapper.deleteAgriCheckById(id);
    }

    @Override
    public List<AgriCheck> selectCheckByPid(String pid) {
        return agriCheckMapper.selectCheckByPid(pid);
    }

    @Override
    public AgriCheck selectCheckByCid(String cid) {
        return agriCheckMapper.selectCheckByCid(cid);
    }

    /**
     *
     *
 * @param check
     * @return int
     * @author sun
     * @create 2022/12/28
     **/

    @Override
    public int submitCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCCheck(check);
    }

    @Override
    public int deleteCheck(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCCheck(id);
    }

    @Override
    public int updateCheck(AgriBCCheck check) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCCheck(check);
    }

    @Override
    public AgriBCCheck queryCheck(String id) throws GatewayException {
        try{
            AgriBCCheck bcCheck = query.queryAgriBCCheck(id);
            return bcCheck;
        }catch (GatewayException e ) {
            return null;
        }


    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }


}
