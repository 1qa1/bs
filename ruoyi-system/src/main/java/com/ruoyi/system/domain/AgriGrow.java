package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.system.domain.AgriMedicine;
import com.ruoyi.system.domain.AgriFertilizer;
import java.util.List;

/**
 * 种植ID管理对象 agri_grow
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_grow")
public class AgriGrow extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 种植表的ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 对应的种植信息的key */
    @Excel(name = "对应的种植信息的key")
    private String gid;

    /** 对应的商品的key */
    @Excel(name = "对应的商品的key")
    private String pid;

    /** 种植时间 */
    @Excel(name = "种植时间")
    private String plantTime;

    /** 收获时间 */
    @Excel(name = "收获时间")
    private String reapTime;

    /** 交易哈希 (区块链凭证) */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriGrow() {
    }

    public AgriGrow(String gid, String pid) {
        this.gid = gid;
        this.pid = pid;
    }

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setGid(String gid) 
    {
        this.gid = gid;
    }

    public String getGid() 
    {
        return gid;
    }
    public void setPid(String pid) 
    {
        this.pid = pid;
    }

    public String getPid() 
    {
        return pid;
    }
    public String getTxHash() {
        return txHash;
    }

    public void setTxHash(String txHash) {
        this.txHash = txHash;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getPlantTime() {
        return plantTime;
    }

    public void setPlantTime(String plantTime) {
        this.plantTime = plantTime;
    }

    public String getReapTime() {
        return reapTime;
    }

    public void setReapTime(String reapTime) {
        this.reapTime = reapTime;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("gid", getGid())
            .append("pid", getPid())
            .append("plantTime", getPlantTime())
            .append("reapTime", getReapTime())
            .append("txHash", getTxHash())
            .append("timeStamp", getTimeStamp())
            .append("status", getStatus())
            .toString();
    }
}
