package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCFertilizer;
import com.ruoyi.system.domain.AgriFertilizer;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 肥料IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriFertilizerService 
{
    /**
     * 查询肥料ID
     * 
     * @param id 肥料ID主键
     * @return 肥料ID
     */
    public AgriFertilizer selectAgriFertilizerById(Long id);
    public void deleteFertilizerByGid( String gid);
    /**
     * 查询肥料ID列表
     * 
     * @param agriFertilizer 肥料ID
     * @return 肥料ID集合
     */
    public List<AgriFertilizer> selectAgriFertilizerList(AgriFertilizer agriFertilizer);
    /**
     * 新增肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    public int insertAgriFertilizer(AgriFertilizer agriFertilizer);

    /**
     * 修改肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    public int updateAgriFertilizer(AgriFertilizer agriFertilizer);

    /**
     * 批量删除肥料ID
     * 
     * @param ids 需要删除的肥料ID主键集合
     * @return 结果
     */
    public int deleteAgriFertilizerByIds(Long[] ids);

    /**
     * 删除肥料ID信息
     * 
     * @param id 肥料ID主键
     * @return 结果
     */
    public int deleteAgriFertilizerById(Long id);
    
    /**
     * 根据gid查询肥料信息
     * 
 * @param gid
     * @return com.ruoyi.system.domain.AgriFertilizer
     * @author sun
     * @create 2022/12/26
     **/
    
    public List<AgriFertilizer> selectFertilizerByGid( String gid);
    public AgriFertilizer selectFertilizerByFid( String fid);

    //     *** blockchain ***
//    add
    public int submitFertilizer(AgriBCFertilizer fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteFertilizer( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateFertilizer(AgriBCFertilizer Fertilizer) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCFertilizer queryFertilizer( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
