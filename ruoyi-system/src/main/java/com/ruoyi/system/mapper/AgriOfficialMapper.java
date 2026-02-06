package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriOfficial;
import org.apache.ibatis.annotations.Mapper;

/**
 * 官方抽查Mapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriOfficialMapper 
{
    /**
     * 查询官方抽查
     * 
     * @param id 官方抽查主键
     * @return 官方抽查
     */
    public AgriOfficial selectAgriOfficialById(Long id);

    /**
     * 查询官方抽查列表
     * 
     * @param agriOfficial 官方抽查
     * @return 官方抽查集合
     */
    public List<AgriOfficial> selectAgriOfficialList(AgriOfficial agriOfficial);

    /**
     * 新增官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    public int insertAgriOfficial(AgriOfficial agriOfficial);

    /**
     * 修改官方抽查
     * 
     * @param agriOfficial 官方抽查
     * @return 结果
     */
    public int updateAgriOfficial(AgriOfficial agriOfficial);

    /**
     * 删除官方抽查
     * 
     * @param id 官方抽查主键
     * @return 结果
     */
    public int deleteAgriOfficialById(Long id);

    /**
     * 批量删除官方抽查
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriOfficialByIds(Long[] ids);

//    根据pid 查询官方抽查id
    public List<AgriOfficial> selectOfficialByPid(String pid);

    public void deleteOfficialByPid( String pid );

//    根据oid选择唯一official
    public AgriOfficial selectOfficialByOid(String oid);
}
