package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 商品检查ID对象 agri_check
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_check")
public class AgriCheck extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 检测表的id */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 上链的检测信息的key */
    @Excel(name = "上链的检测信息的key")
    private String cid;

    /** 对应的商品的key */
    @Excel(name = "对应的商品的key")
    private String pid;

    /** 对应的链上的种植信息的key */
    @Excel(name = "对应的链上的种植信息的key")
    private String gid;

    /** 检查项目名称 */
    @Excel(name = "检查项目名称")
    private String projName;

    /** 检查类型 */
    @Excel(name = "检查类型")
    private String types;

    /** 检查结果 */
    @Excel(name = "检查结果")
    private String result;

    /** 检测报告地址 */
    @Excel(name = "检测报告地址")
    private String uploadsUrl;

    /** 交易哈希 */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriCheck() {
    }

    public AgriCheck(String cid, String pid) {
        this.cid = cid;
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
    public void setCid(String cid)
    {
        this.cid = cid;
    }

    public String getCid()
    {
        return cid;
    }
    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPid()
    {
        return pid;
    }

    public String getGid() {
        return gid;
    }

    public void setGid(String gid) {
        this.gid = gid;
    }

    public String getProjName() {
        return projName;
    }

    public void setProjName(String projName) {
        this.projName = projName;
    }

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getUploadsUrl() {
        return uploadsUrl;
    }

    public void setUploadsUrl(String uploadsUrl) {
        this.uploadsUrl = uploadsUrl;
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
                .append("cid", getCid())
                .append("pid", getPid())
                .append("gid", getGid())
                .append("projName", getProjName())
                .append("types", getTypes())
                .append("result", getResult())
                .append("uploadsUrl", getUploadsUrl())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}