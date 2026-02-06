package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCFertilizer;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriFertilizerMapper;
import com.ruoyi.system.domain.AgriFertilizer;
import com.ruoyi.system.service.IAgriFertilizerService;

/**
 * 肥料IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriFertilizerServiceImpl implements IAgriFertilizerService 
{
    @Autowired
    private AgriFertilizerMapper agriFertilizerMapper;
    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;
    /**
     * 查询肥料ID
     * 
     * @param id 肥料ID主键
     * @return 肥料ID
     */
    @Override
    public AgriFertilizer selectAgriFertilizerById(Long id)
    {
        return agriFertilizerMapper.selectAgriFertilizerById(id);
    }

    @Override
    public void deleteFertilizerByGid(String gid) {
        agriFertilizerMapper.deleteFertilizerByGid(gid);
    }

    /**
     * 查询肥料ID列表
     * 
     * @param agriFertilizer 肥料ID
     * @return 肥料ID
     */
    @Override
    public List<AgriFertilizer> selectAgriFertilizerList(AgriFertilizer agriFertilizer)
    {
        return agriFertilizerMapper.selectAgriFertilizerList(agriFertilizer);
    }

    /**
     * 新增肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    @Override
    public int insertAgriFertilizer(AgriFertilizer agriFertilizer)
    {
        return agriFertilizerMapper.insertAgriFertilizer(agriFertilizer);
    }

    /**
     * 修改肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    @Override
    public int updateAgriFertilizer(AgriFertilizer agriFertilizer)
    {
        return agriFertilizerMapper.updateAgriFertilizer(agriFertilizer);
    }

    /**
     * 批量删除肥料ID
     * 
     * @param ids 需要删除的肥料ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriFertilizerByIds(Long[] ids)
    {
        return agriFertilizerMapper.deleteAgriFertilizerByIds(ids);
    }

    /**
     * 删除肥料ID信息
     * 
     * @param id 肥料ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriFertilizerById(Long id)
    {
        return agriFertilizerMapper.deleteAgriFertilizerById(id);
    }

    @Override
    public List<AgriFertilizer> selectFertilizerByGid(String gid) {
        return agriFertilizerMapper.selectFertilizerByGid(gid);
    }

    @Override
    public AgriFertilizer selectFertilizerByFid(String fid) {
        return agriFertilizerMapper.selectFertilizerByFid(fid);
    }

    @Override
    public int submitFertilizer(AgriBCFertilizer fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException {
       return submit.insertAgriBCFertilizer(fertilizer);
    }

    @Override
    public int deleteFertilizer(String id) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCFertilizer(id);
    }

    @Override
    public int updateFertilizer(AgriBCFertilizer fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCFertilizer(fertilizer);
    }

    @Override
    public AgriBCFertilizer queryFertilizer(String id) {
        try {
            AgriBCFertilizer bcFertilizer = query.queryAgriBCFertilizer(id);
            return bcFertilizer;
        } catch (GatewayException e) {
            return null;
        }
    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
