package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriCheck;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商品检查IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriCheckMapper 
{
    /**
     * 查询商品检查ID
     * 
     * @param id 商品检查ID主键
     * @return 商品检查ID
     */
    public AgriCheck selectAgriCheckById(Long id);

    /**
     * 查询商品检查ID列表
     * 
     * @param agriCheck 商品检查ID
     * @return 商品检查ID集合
     */
    public List<AgriCheck> selectAgriCheckList(AgriCheck agriCheck);

    /**
     * 新增商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    public int insertAgriCheck(AgriCheck agriCheck);

    /**
     * 修改商品检查ID
     * 
     * @param agriCheck 商品检查ID
     * @return 结果
     */
    public int updateAgriCheck(AgriCheck agriCheck);

    /**
     * 删除商品检查ID
     * 
     * @param id 商品检查ID主键
     * @return 结果
     */
    public int deleteAgriCheckById(Long id);

    /**
     * 批量删除商品检查ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriCheckByIds(Long[] ids);


//    根据pid查询check
    public List<AgriCheck> selectCheckByPid( String pid);

//    根据cid查询到唯一数值
    public AgriCheck selectCheckByCid ( String cid);

//   根据pid值 删除check
    public void deleteCheckByPid( String pid);
}
