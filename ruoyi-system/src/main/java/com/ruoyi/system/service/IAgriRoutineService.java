package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCRoutineCheck;
import com.ruoyi.system.domain.AgriRoutine;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 日常抽查Service接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriRoutineService 
{
    /**
     * 查询日常抽查
     * 
     * @param id 日常抽查主键
     * @return 日常抽查
     */
    public AgriRoutine selectAgriRoutineById(Long id);

    public void deleteRoutineByPid( String pid);

    /**
     * 查询日常抽查列表
     * 
     * @param agriRoutine 日常抽查
     * @return 日常抽查集合
     */
    public List<AgriRoutine> selectAgriRoutineList(AgriRoutine agriRoutine);

    /**
     * 新增日常抽查
     * 
     * @param agriRoutine 日常抽查
     * @return 结果
     */
    public int insertAgriRoutine(AgriRoutine agriRoutine);

    /**
     * 修改日常抽查
     * 
     * @param agriRoutine 日常抽查
     * @return 结果
     */
    public int updateAgriRoutine(AgriRoutine agriRoutine);

    /**
     * 批量删除日常抽查
     * 
     * @param ids 需要删除的日常抽查主键集合
     * @return 结果
     */
    public int deleteAgriRoutineByIds(Long[] ids);

    /**
     * 删除日常抽查信息
     * 
     * @param id 日常抽查主键
     * @return 结果
     */
    public int deleteAgriRoutineById(Long id);

    /**
     *  根据pid查询到日常检查信息
     *
 * @param pid
     * @return com.ruoyi.system.domain.AgriRoutine
     * @author sun
     * @create 2022/12/26
     **/

    public List<AgriRoutine> selectRoutineByPid( String pid);
    public AgriRoutine selectRoutineByRid( String rid);
    //     *** blockchain ***
//    add
    public int submitRoutineCheck(AgriBCRoutineCheck RoutineCheck) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteRoutineCheck( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateRoutineCheck(AgriBCRoutineCheck RoutineCheck) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCRoutineCheck queryRoutineCheck( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
