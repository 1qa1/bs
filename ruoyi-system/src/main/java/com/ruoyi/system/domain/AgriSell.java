package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 售卖信息ID对象 agri_sell
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_sell")
public class AgriSell extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 销售表的ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 销售信息上链Key */
    @Excel(name = "销售信息上链Key")
    private String sid;

    /** 对应的商品的Key */
    @Excel(name = "对应的商品的Key")
    private String pid;

    /** 到达时间 */
    @Excel(name = "到达时间")
    private String arrivalTime;

    /** 售卖数量 */
    @Excel(name = "售卖数量")
    private String amount;

    /** 检验时间 */
    @Excel(name = "检验时间")
    private String checkTime;

    /** 检验项目 */
    @Excel(name = "检验项目")
    private String checkName;

    /** 检验结果 */
    @Excel(name = "检验结果")
    private String checkResult;

    /** 商品规格 */
    @Excel(name = "商品规格")
    private String tp;

    /** 交易哈希 */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriSell() {
    }

    public AgriSell(String sid, String pid) {
        this.sid = sid;
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
    public void setSid(String sid)
    {
        this.sid = sid;
    }

    public String getSid()
    {
        return sid;
    }
    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPid()
    {
        return pid;
    }

    public String getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(String arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCheckTime() {
        return checkTime;
    }

    public void setCheckTime(String checkTime) {
        this.checkTime = checkTime;
    }

    public String getCheckName() {
        return checkName;
    }

    public void setCheckName(String checkName) {
        this.checkName = checkName;
    }

    public String getCheckResult() {
        return checkResult;
    }

    public void setCheckResult(String checkResult) {
        this.checkResult = checkResult;
    }

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
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
                .append("sid", getSid())
                .append("pid", getPid())
                .append("arrivalTime", getArrivalTime())
                .append("amount", getAmount())
                .append("checkTime", getCheckTime())
                .append("checkName", getCheckName())
                .append("checkResult", getCheckResult())
                .append("tp", getTp())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}