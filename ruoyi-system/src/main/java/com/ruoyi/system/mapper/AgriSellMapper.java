package com.ruoyi.system.mapper;

import java.util.List;
import com.ruoyi.system.domain.AgriSell;
import org.apache.ibatis.annotations.Mapper;

/**
 * 售卖信息IDMapper接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@Mapper
public interface AgriSellMapper 
{
    /**
     * 查询售卖信息ID
     * 
     * @param id 售卖信息ID主键
     * @return 售卖信息ID
     */
    public AgriSell selectAgriSellById(Long id);

    /**
     * 查询售卖信息ID列表
     * 
     * @param agriSell 售卖信息ID
     * @return 售卖信息ID集合
     */
    public List<AgriSell> selectAgriSellList(AgriSell agriSell);

    /**
     * 新增售卖信息ID
     * 
     * @param agriSell 售卖信息ID
     * @return 结果
     */
    public int insertAgriSell(AgriSell agriSell);

    /**
     * 修改售卖信息ID
     * 
     * @param agriSell 售卖信息ID
     * @return 结果
     */
    public int updateAgriSell(AgriSell agriSell);

    /**
     * 删除售卖信息ID
     * 
     * @param id 售卖信息ID主键
     * @return 结果
     */
    public int deleteAgriSellById(Long id);

    /**
     * 批量删除售卖信息ID
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAgriSellByIds(Long[] ids);

//    根据pid查询出sell信息
    public List<AgriSell> selectSellByPid( String pid);

    public void deleteSellByPid( String pid );

//    根据sid查询唯一值
    public AgriSell selectSellBySid( String sid);
}
