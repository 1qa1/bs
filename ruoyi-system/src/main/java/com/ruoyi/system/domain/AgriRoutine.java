package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 日常抽查对象 agri_routine
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_routine")
public class AgriRoutine extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日常检测ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 日常检测上链的ID */
    @Excel(name = "日常检测上链的ID")
    private String rid;

    /** 对应的商品上链的ID */
    @Excel(name = "对应的商品上链的ID")
    private String pid;

    /** 检查项目名称 */
    @Excel(name = "检查项目名称")
    private String checkName;

    /** 检查日期 */
    @Excel(name = "检查日期")
    private String checkTime;

    /** 检查问题 */
    @Excel(name = "检查问题")
    private String problems;

    /** 检查建议 */
    @Excel(name = "检查建议")
    private String proposal;

    /** 参与人员 */
    @Excel(name = "参与人员")
    private String orgMember;

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

    public AgriRoutine() {
    }

    public AgriRoutine(String rid, String pid) {
        this.rid = rid;
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
    public void setRid(String rid)
    {
        this.rid = rid;
    }

    public String getRid()
    {
        return rid;
    }
    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPid()
    {
        return pid;
    }

    public String getCheckName() {
        return checkName;
    }

    public void setCheckName(String checkName) {
        this.checkName = checkName;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }

    public String getProblems() {
        return problems;
    }

    public void setProblems(String problems) {
        this.problems = problems;
    }

    public String getProposal() {
        return proposal;
    }

    public void setProposal(String proposal) {
        this.proposal = proposal;
    }

    public String getOrgMember() {
        return orgMember;
    }

    public void setOrgMember(String orgMember) {
        this.orgMember = orgMember;
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
                .append("rid", getRid())
                .append("pid", getPid())
                .append("checkName", getCheckName())
                .append("checkTime", getCheckTime())
                .append("problems", getProblems())
                .append("proposal", getProposal())
                .append("orgMember", getOrgMember())
                .append("uploadsUrl", getUploadsUrl())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}