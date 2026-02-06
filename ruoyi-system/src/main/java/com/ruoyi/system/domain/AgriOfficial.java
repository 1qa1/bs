package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 官方抽查对象 agri_official
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_official")
public class AgriOfficial extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 官方抽查的id */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 上链的官方抽查的key */
    @Excel(name = "上链的官方抽查的key")
    private String oid;

    /** 对应的商品的上链id */
    @Excel(name = "对应的商品的上链id")
    private String pid;

    /** 抽检时间 */
    @Excel(name = "抽检时间")
    private String reportTime;

    /** 检查结果 */
    @Excel(name = "检查结果")
    private String reportResult;

    /** 检测报告地址 */
    @Excel(name = "检测报告地址")
    private String reportUploadsUrl;

    /** 交易哈希 */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriOfficial() {
    }

    public AgriOfficial(String oid, String pid) {
        this.oid = oid;
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
    public void setOid(String oid)
    {
        this.oid = oid;
    }

    public String getOid()
    {
        return oid;
    }
    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPid()
    {
        return pid;
    }

    public String getReportTime() {
        return reportTime;
    }

    public void setReportTime(String reportTime) {
        this.reportTime = reportTime;
    }

    public String getReportResult() {
        return reportResult;
    }

    public void setReportResult(String reportResult) {
        this.reportResult = reportResult;
    }

    public String getReportUploadsUrl() {
        return reportUploadsUrl;
    }

    public void setReportUploadsUrl(String reportUploadsUrl) {
        this.reportUploadsUrl = reportUploadsUrl;
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
                .append("oid", getOid())
                .append("pid", getPid())
                .append("reportTime", getReportTime())
                .append("reportResult", getReportResult())
                .append("reportUploadsUrl", getReportUploadsUrl())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}