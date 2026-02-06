package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriProduct;
import org.apache.ibatis.annotations.Mapper;

/**
 * 产品IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriProductMapper 
{
    /**
     * 查询产品ID
     * 
     * @param id 产品ID主键
     * @return 产品ID
     */
    public AgriProduct selectAgriProductById(Long id);

    /**
     * 查询产品ID列表
     * 
     * @param agriProduct 产品ID
     * @return 产品ID集合
     */
    public List<AgriProduct> selectAgriProductList(AgriProduct agriProduct);

    /**
     * 新增产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    public int insertAgriProduct(AgriProduct agriProduct);

    /**
     * 修改产品ID
     * 
     * @param agriProduct 产品ID
     * @return 结果
     */
    public int updateAgriProduct(AgriProduct agriProduct);

    /**
     * 删除产品ID
     * 
     * @param id 产品ID主键
     * @return 结果
     */
    public int deleteAgriProductById(Long id);

    /**
     * 批量删除产品ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriProductByIds(Long[] ids);

//
    public AgriProduct selectProductByPid( String pid);
}
