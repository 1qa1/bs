package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriTx;
import org.apache.ibatis.annotations.Mapper;

/**
 * 交易信息Mapper接口
 * 
 * @author ruoyi
 * @date 2022-12-31
 */
@Mapper
public interface AgriTxMapper 
{
    /**
     * 查询交易信息
     * 
     * @param pid 交易信息主键
     * @return 交易信息
     */
    public AgriTx selectAgriTxByPid(String pid);

    /**
     * 查询交易信息列表
     * 
     * @param agriTx 交易信息
     * @return 交易信息集合
     */
    public List<AgriTx> selectAgriTxList(AgriTx agriTx);

    /**
     * 新增交易信息
     * 
     * @param agriTx 交易信息
     * @return 结果
     */
    public int insertAgriTx(AgriTx agriTx);

    /**
     * 修改交易信息
     * 
     * @param agriTx 交易信息
     * @return 结果
     */
    public int updateAgriTx(AgriTx agriTx);

    /**
     * 删除交易信息
     * 
     * @param pid 交易信息主键
     * @return 结果
     */
    public int deleteAgriTxByPid(String pid);

    /**
     * 批量删除交易信息
     * 
     * @param pids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriTxByPids(String[] pids);
}
