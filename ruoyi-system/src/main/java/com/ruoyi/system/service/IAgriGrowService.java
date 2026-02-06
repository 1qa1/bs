package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.*;
import org.hyperledger.fabric.client.*;

/**
 * 种植ID管理Service接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriGrowService 
{
    /**
     * 查询种植ID管理
     * 
     * @param id 种植ID管理主键
     * @return 种植ID管理
     */
    public AgriGrow selectAgriGrowById(Long id);

    public void deleteGrowByPid( String pid);

    /**
     * 查询种植ID管理列表
     * 
     * @param agriGrow 种植ID管理
     * @return 种植ID管理集合
     */
    public List<AgriGrow> selectAgriGrowList(AgriGrow agriGrow);

    /**
     * 新增种植ID管理
     * 
     * @param agriGrow 种植ID管理
     * @return 结果
     */
    public int insertAgriGrow(AgriGrow agriGrow);

    /**
     * 修改种植ID管理
     * 
     * @param agriGrow 种植ID管理
     * @return 结果
     */
    public int updateAgriGrow(AgriGrow agriGrow);

    /**
     * 批量删除种植ID管理
     * 
     * @param ids 需要删除的种植ID管理主键集合
     * @return 结果
     */
    public int deleteAgriGrowByIds(Long[] ids);

    /**
     * 删除种植ID管理信息
     * 
     * @param id 种植ID管理主键
     * @return 结果
     */
    public int deleteAgriGrowById(Long id);


    /**
     *  根据pid查询种植信息
     *
     * @param pid
     * @return com.ruoyi.system.domain.AgriGrow
     * @author sun
     * @create 2022/12/26
     **/


    public List<AgriGrow> selectGrowByPid( String pid);
    public AgriGrow selectGrowByGid( String gid);
    //     *** blockchain ***
//    add
    public int submitGrow(AgriBCGrow grow) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteGrow( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateGrow(AgriBCGrow Grow) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCGrow queryGrow( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
