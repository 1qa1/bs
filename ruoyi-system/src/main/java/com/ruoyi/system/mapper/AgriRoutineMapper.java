package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriRoutine;
import org.apache.ibatis.annotations.Mapper;

/**
 * 日常抽查Mapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriRoutineMapper 
{
    /**
     * 查询日常抽查
     * 
     * @param id 日常抽查主键
     * @return 日常抽查
     */
    public AgriRoutine selectAgriRoutineById(Long id);

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
     * 删除日常抽查
     * 
     * @param id 日常抽查主键
     * @return 结果
     */
    public int deleteAgriRoutineById(Long id);

    /**
     * 批量删除日常抽查
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriRoutineByIds(Long[] ids);

//    根据pid查询出日常检查信息
    public List<AgriRoutine> selectRoutineByPid( String pid);

    public void deleteRoutineByPid( String pid );

//    根据rid查询唯一列
    public AgriRoutine selectRoutineByRid( String rid);
}
