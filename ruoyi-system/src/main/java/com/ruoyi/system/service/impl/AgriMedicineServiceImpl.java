package com.ruoyi.system.service.impl;

import java.util.List;

import com.ruoyi.system.blockchain.delete.DeleteFromBlockChain;
import com.ruoyi.system.blockchain.query.QueryFromBlockChain;
import com.ruoyi.system.blockchain.submit.SubmitToBlockChain;
import com.ruoyi.system.blockchain.update.UpdateToBlockChain;
import com.ruoyi.system.domain.AgriBCMedicine;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriMedicineMapper;
import com.ruoyi.system.domain.AgriMedicine;
import com.ruoyi.system.service.IAgriMedicineService;

/**
 * 药品IDService业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Service
public class AgriMedicineServiceImpl implements IAgriMedicineService {
    @Autowired
    private AgriMedicineMapper agriMedicineMapper;

    @Autowired
    private QueryFromBlockChain query;

    @Autowired
    private SubmitToBlockChain submit;

    @Autowired
    private UpdateToBlockChain update;

    @Autowired
    private DeleteFromBlockChain delete;

    /**
     * 查询药品ID
     * 
     * @param id 药品ID主键
     * @return 药品ID
     */
    @Override
    public AgriMedicine selectAgriMedicineById(Long id) {
        return agriMedicineMapper.selectAgriMedicineById(id);
    }

    @Override
    public void deleteMedicineByGid(String gid) {
        agriMedicineMapper.deleteMedicineByGid(gid);
    }

    /**
     * 查询药品ID列表
     * 
     * @param agriMedicine 药品ID
     * @return 药品ID
     */
    @Override
    public List<AgriMedicine> selectAgriMedicineList(AgriMedicine agriMedicine) {
        return agriMedicineMapper.selectAgriMedicineList(agriMedicine);
    }

    /**
     * 新增药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    @Override
    public int insertAgriMedicine(AgriMedicine agriMedicine) {
        return agriMedicineMapper.insertAgriMedicine(agriMedicine);
    }

    /**
     * 修改药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    @Override
    public int updateAgriMedicine(AgriMedicine agriMedicine) {
        return agriMedicineMapper.updateAgriMedicine(agriMedicine);
    }

    /**
     * 批量删除药品ID
     * 
     * @param ids 需要删除的药品ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriMedicineByIds(Long[] ids) {
        return agriMedicineMapper.deleteAgriMedicineByIds(ids);
    }

    /**
     * 删除药品ID信息
     * 
     * @param id 药品ID主键
     * @return 结果
     */
    @Override
    public int deleteAgriMedicineById(Long id) {
        return agriMedicineMapper.deleteAgriMedicineById(id);
    }

    @Override
    public List<AgriMedicine> selectMedicineByGid(String gid) {
        return agriMedicineMapper.selectMedicineByGid(gid);
    }

    @Override
    public List<AgriMedicine> selectMedicineByPid(String pid) {
        return agriMedicineMapper.selectMedicineByPid(pid);
    }

    @Override
    public AgriMedicine selectMedicineByMid(String mid) {
        return agriMedicineMapper.selectMedicineByMid(mid);
    }

    @Override
    public int submitMedicine(AgriBCMedicine Medicine)
            throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return submit.insertAgriBCMedicine(Medicine);
    }

    @Override
    public int deleteMedicine(String id)
            throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return delete.deleteAgriBCMedicine(id);
    }

    @Override
    public int updateMedicine(AgriBCMedicine Medicine)
            throws EndorseException, CommitException, SubmitException, CommitStatusException {
        return update.updateAgriBCMedicine(Medicine);
    }

    @Override
    public AgriBCMedicine queryMedicine(String id) {
        try {
            AgriBCMedicine bcMedicine = query.queryAgriBCMedicine(id);
            return bcMedicine;
        } catch (GatewayException e) {
            return null;
        }

    }

    @Override
    public AgriTx queryTxHash() throws GatewayException {
        return query.queryTransaction();
    }
}
