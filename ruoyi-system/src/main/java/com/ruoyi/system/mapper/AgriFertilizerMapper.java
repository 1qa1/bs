package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriFertilizer;
import org.apache.ibatis.annotations.Mapper;

/**
 * 肥料IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriFertilizerMapper 
{
    /**
     * 查询肥料ID
     * 
     * @param id 肥料ID主键
     * @return 肥料ID
     */
    public AgriFertilizer selectAgriFertilizerById(Long id);

    /**
     * 查询肥料ID列表
     * 
     * @param agriFertilizer 肥料ID
     * @return 肥料ID集合
     */
    public List<AgriFertilizer> selectAgriFertilizerList(AgriFertilizer agriFertilizer);

    /**
     * 新增肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    public int insertAgriFertilizer(AgriFertilizer agriFertilizer);

    /**
     * 修改肥料ID
     * 
     * @param agriFertilizer 肥料ID
     * @return 结果
     */
    public int updateAgriFertilizer(AgriFertilizer agriFertilizer);

    /**
     * 删除肥料ID
     * 
     * @param id 肥料ID主键
     * @return 结果
     */
    public int deleteAgriFertilizerById(Long id);

    /**
     * 批量删除肥料ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriFertilizerByIds(Long[] ids);


//    根据gid查询肥料信息
    public List<AgriFertilizer> selectFertilizerByGid(String gid);

//    根据gid的值删除fertilizer
    public void deleteFertilizerByGid( String gid );


//    根据fid查询唯一值
    public AgriFertilizer selectFertilizerByFid( String fid);
}
