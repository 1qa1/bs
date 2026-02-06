package com.ruoyi.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.mapper.AgriTxMapper;
import com.ruoyi.system.domain.AgriTx;
import com.ruoyi.system.service.IAgriTxService;

/**
 * 交易信息Service业务层处理
 * 
 * @author ruoyi
 * @date 2022-12-31
 */
@Service
public class AgriTxServiceImpl implements IAgriTxService 
{
    @Autowired
    private AgriTxMapper agriTxMapper;

    /**
     * 查询交易信息
     * 
     * @param pid 交易信息主键
     * @return 交易信息
     */
    @Override
    public AgriTx selectAgriTxByPid(String pid)
    {
        return agriTxMapper.selectAgriTxByPid(pid);
    }

    /**
     * 查询交易信息列表
     * 
     * @param agriTx 交易信息
     * @return 交易信息
     */
    @Override
    public List<AgriTx> selectAgriTxList(AgriTx agriTx)
    {
        return agriTxMapper.selectAgriTxList(agriTx);
    }

    /**
     * 新增交易信息
     * 
     * @param agriTx 交易信息
     * @return 结果
     */
    @Override
    public int insertAgriTx(AgriTx agriTx)
    {
        return agriTxMapper.insertAgriTx(agriTx);
    }

    /**
     * 修改交易信息
     * 
     * @param agriTx 交易信息
     * @return 结果
     */
    @Override
    public int updateAgriTx(AgriTx agriTx)
    {
        return agriTxMapper.updateAgriTx(agriTx);
    }

    /**
     * 批量删除交易信息
     * 
     * @param pids 需要删除的交易信息主键
     * @return 结果
     */
    @Override
    public int deleteAgriTxByPids(String[] pids)
    {
        return agriTxMapper.deleteAgriTxByPids(pids);
    }

    /**
     * 删除交易信息信息
     * 
     * @param pid 交易信息主键
     * @return 结果
     */
    @Override
    public int deleteAgriTxByPid(String pid)
    {
        return agriTxMapper.deleteAgriTxByPid(pid);
    }
}
