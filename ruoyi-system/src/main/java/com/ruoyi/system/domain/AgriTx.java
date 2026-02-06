package com.ruoyi.system.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 交易信息对象 agri_tx
 * 
 * @author ruoyi
 * @date 2022-12-31
 */
public class AgriTx extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 商品的Key */
    private String pid;

    /** 交易hash */
    @Excel(name = "交易hash")
    private String txid;

    /** 交易时间戳 */
    @Excel(name = "交易时间戳")
    private String timestamp;

    public void setPid(String pid) 
    {
        this.pid = pid;
    }

    public String getPid() 
    {
        return pid;
    }
    public void setTxid(String txid) 
    {
        this.txid = txid;
    }

    public String getTxid() 
    {
        return txid;
    }
    public void setTimestamp(String timestamp) 
    {
        this.timestamp = timestamp;
    }

    public String getTimestamp() 
    {
        return timestamp;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("pid", getPid())
            .append("txid", getTxid())
            .append("timestamp", getTimestamp())
            .toString();
    }
}
