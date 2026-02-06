package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCMedicine;
import com.ruoyi.system.domain.AgriMedicine;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 药品IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriMedicineService {
    /**
     * 查询药品ID
     * 
     * @param id 药品ID主键
     * @return 药品ID
     */
    public AgriMedicine selectAgriMedicineById(Long id);

    public void deleteMedicineByGid(String gid);

    /**
     * 查询药品ID列表
     * 
     * @param agriMedicine 药品ID
     * @return 药品ID集合
     */
    public List<AgriMedicine> selectAgriMedicineList(AgriMedicine agriMedicine);

    /**
     * 新增药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    public int insertAgriMedicine(AgriMedicine agriMedicine);

    /**
     * 修改药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    public int updateAgriMedicine(AgriMedicine agriMedicine);

    /**
     * 批量删除药品ID
     * 
     * @param ids 需要删除的药品ID主键集合
     * @return 结果
     */
    public int deleteAgriMedicineByIds(Long[] ids);

    /**
     * 删除药品ID信息
     * 
     * @param id 药品ID主键
     * @return 结果
     */
    public int deleteAgriMedicineById(Long id);

    /**
     * 根据gid查新到用药信息
     *
     * @param gid
     * @return com.ruoyi.system.domain.AgriMedicine
     * @author sun
     * @create 2022/12/26
     **/

    public List<AgriMedicine> selectMedicineByGid(String gid);

    /**
     * 根据产品PID查询用药信息
     * 
     * @param pid 产品PID
     * @return 用药信息列表
     */
    public List<AgriMedicine> selectMedicineByPid(String pid);

    public AgriMedicine selectMedicineByMid(String mid);

    // *** blockchain ***
    // add
    public int submitMedicine(AgriBCMedicine Medicine)
            throws EndorseException, CommitException, SubmitException, CommitStatusException;

    // delete
    public int deleteMedicine(String id)
            throws EndorseException, CommitException, SubmitException, CommitStatusException;

    // update
    public int updateMedicine(AgriBCMedicine Medicine)
            throws EndorseException, CommitException, SubmitException, CommitStatusException;

    // query
    public AgriBCMedicine queryMedicine(String id) throws GatewayException;

    // 获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
