package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 肥料ID对象 agri_fertilizer
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_fertilizer")
public class AgriFertilizer extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 肥料表ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 对应链上肥料表的key */
    @Excel(name = "对应链上肥料表的key")
    private String fid;

    /** 对应的链上的种植信息的key */
    @Excel(name = "对应的链上的种植信息的key")
    private String gid;

    /** 对应的商品的key */
    @Excel(name = "对应的商品的key")
    private String pid;

    /** 肥料名称 */
    @Excel(name = "肥料名称")
    private String name;

    /** 肥料公司 */
    @Excel(name = "肥料公司")
    private String company;

    /** 生产批号 */
    @Excel(name = "生产批号")
    private String batchNo;

    /** 使用时间 */
    @Excel(name = "使用时间")
    private String useTime;

    /** 交易哈希 */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriFertilizer() {
    }

    public AgriFertilizer(String fid, String gid) {
        this.fid = fid;
        this.gid = gid;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }
    public void setFid(String fid)
    {
        this.fid = fid;
    }

    public String getFid()
    {
        return fid;
    }
    public void setGid(String gid)
    {
        this.gid = gid;
    }

    public String getGid()
    {
        return gid;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public String getUseTime() {
        return useTime;
    }

    public void setUseTime(String useTime) {
        this.useTime = useTime;
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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("fid", getFid())
                .append("gid", getGid())
                .append("pid", getPid())
                .append("name", getName())
                .append("company", getCompany())
                .append("batchNo", getBatchNo())
                .append("useTime", getUseTime())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}