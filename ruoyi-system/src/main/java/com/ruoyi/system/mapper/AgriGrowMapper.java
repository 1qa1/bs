package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriGrow;
import org.apache.ibatis.annotations.Mapper;

/**
 * 种植ID管理Mapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriGrowMapper 
{
    /**
     * 查询种植ID管理
     * 
     * @param id 种植ID管理主键
     * @return 种植ID管理
     */
    public AgriGrow selectAgriGrowById(Long id);

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
     * 删除种植ID管理
     * 
     * @param id 种植ID管理主键
     * @return 结果
     */
    public int deleteAgriGrowById(Long id);

    /**
     * 批量删除种植ID管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriGrowByIds(Long[] ids);

//    根据pid查询种植id
    public List<AgriGrow> selectGrowByPid( String pid);

    public void deleteGrowByPid( String pid);

//    根据gid查询
    public AgriGrow selectGrowByGid( String gid);
}
