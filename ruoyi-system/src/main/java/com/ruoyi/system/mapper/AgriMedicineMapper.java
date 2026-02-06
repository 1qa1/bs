package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriMedicine;
import org.apache.ibatis.annotations.Mapper;

/**
 * 药品IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriMedicineMapper {
    /**
     * 查询药品ID
     * 
     * @param id 药品ID主键
     * @return 药品ID
     */
    public AgriMedicine selectAgriMedicineById(Long id);

    /**
     * 查询药品ID列表
     * 
     * @param agriMedicine 药品ID
     * @return 药品ID集合
     */
    public List<AgriMedicine> selectAgriMedicineList(AgriMedicine agriMedicine);

    /**
     * 新增药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    public int insertAgriMedicine(AgriMedicine agriMedicine);

    /**
     * 修改药品ID
     * 
     * @param agriMedicine 药品ID
     * @return 结果
     */
    public int updateAgriMedicine(AgriMedicine agriMedicine);

    /**
     * 删除药品ID
     * 
     * @param id 药品ID主键
     * @return 结果
     */
    public int deleteAgriMedicineById(Long id);

    /**
     * 批量删除药品ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriMedicineByIds(Long[] ids);

    // 根据gid查询用药信息id
    public List<AgriMedicine> selectMedicineByGid(String gid);

    /**
     * 根据产品PID查询用药信息
     * 
     * @param pid 产品PID
     * @return 用药信息列表
     */
    public List<AgriMedicine> selectMedicineByPid(String pid);

    public void deleteMedicineByGid(String gid);

    // 根据mid选择出唯一的Medicine
    public AgriMedicine selectMedicineByMid(String mid);
}
