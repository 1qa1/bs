package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriTransport;
import org.apache.ibatis.annotations.Mapper;

/**
 * 运输信息IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriTransportMapper 
{
    /**
     * 查询运输信息ID
     * 
     * @param id 运输信息ID主键
     * @return 运输信息ID
     */
    public AgriTransport selectAgriTransportById(Long id);

    /**
     * 查询运输信息ID列表
     * 
     * @param agriTransport 运输信息ID
     * @return 运输信息ID集合
     */
    public List<AgriTransport> selectAgriTransportList(AgriTransport agriTransport);

    /**
     * 新增运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    public int insertAgriTransport(AgriTransport agriTransport);

    /**
     * 修改运输信息ID
     * 
     * @param agriTransport 运输信息ID
     * @return 结果
     */
    public int updateAgriTransport(AgriTransport agriTransport);

    /**
     * 删除运输信息ID
     * 
     * @param id 运输信息ID主键
     * @return 结果
     */
    public int deleteAgriTransportById(Long id);

    /**
     * 批量删除运输信息ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriTransportByIds(Long[] ids);

//    根据pid查询出运输id
    public List<AgriTransport> selectTransportByPid( String pid);

    public void deleteTransportByPid( String pid );

//    根据tid查询唯一值
    public AgriTransport selectTransportByTid( String tid);
}
