package com.ruoyi.system.service;

import java.util.List;

import com.ruoyi.system.domain.AgriBCSell;
import com.ruoyi.system.domain.AgriSell;
import com.ruoyi.system.domain.AgriTx;
import org.hyperledger.fabric.client.*;

/**
 * 售卖信息IDService接口
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
public interface IAgriSellService 
{
    /**
     * 查询售卖信息ID
     * 
     * @param id 售卖信息ID主键
     * @return 售卖信息ID
     */
    public AgriSell selectAgriSellById(Long id);

    public void deleteSellByPid( String pid);

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
     * 批量删除售卖信息ID
     * 
     * @param ids 需要删除的售卖信息ID主键集合
     * @return 结果
     */
    public int deleteAgriSellByIds(Long[] ids);

    /**
     * 删除售卖信息ID信息
     * 
     * @param id 售卖信息ID主键
     * @return 结果
     */
    public int deleteAgriSellById(Long id);
    
    /**
     *  根据pid查询到售卖信息
     * 
 * @param pid
     * @return com.ruoyi.system.domain.AgriSell
     * @author sun
     * @create 2022/12/26
     **/
    
    public List<AgriSell> selectSellByPid( String pid);
    public AgriSell selectSellBySid( String sid);
    //     *** blockchain ***
//    add
    public int submitSell(AgriBCSell Sell) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    delete
    public int deleteSell( String id) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    update
    public int updateSell(AgriBCSell Sell) throws EndorseException, CommitException, SubmitException, CommitStatusException;
    //    query
    public AgriBCSell querySell( String id) throws GatewayException;

    //    获取区块信息
    public AgriTx queryTxHash() throws GatewayException;
}
