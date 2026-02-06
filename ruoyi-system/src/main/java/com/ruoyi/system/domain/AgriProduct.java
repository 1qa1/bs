package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.List;

/**
 * 产品ID对象 agri_product
 * 
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_product")
public class AgriProduct extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 商品的ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 商品的key */
    @Excel(name = "商品的key")
    private String pid;

    /** 对应商品的运输id */
    @Excel(name = "商品的名称")
    private String name;

    @Excel(name = "商品唯一码")
    private String onlyCode;

    @Excel(name = "种植数量")
    private String number;

    @Excel(name = "规格")
    private String tp;

    @Excel(name = "种植地")
    private String plantCity;

    /** 交易哈希 (区块链凭证) */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriProduct() {
    }

    public AgriProduct(String pid, String name) {
        this.pid = pid;
        this.name = name;
    }

    private List<AgriCheck> checks;
    private List<AgriGrow> grows;
    private List<AgriOfficial> officials;
    private List<AgriRoutine> routines;
    private List<AgriSell> sells;
    private List<AgriTransport> transports;

    public List<AgriCheck> getChecks() {
        return checks;
    }

    public void setChecks(List<AgriCheck> checks) {
        this.checks = checks;
    }

    public List<AgriGrow> getGrows() {
        return grows;
    }

    public void setGrows(List<AgriGrow> grows) {
        this.grows = grows;
    }

    public List<AgriOfficial> getOfficials() {
        return officials;
    }

    public void setOfficials(List<AgriOfficial> officials) {
        this.officials = officials;
    }

    public List<AgriRoutine> getRoutines() {
        return routines;
    }

    public void setRoutines(List<AgriRoutine> routines) {
        this.routines = routines;
    }

    public List<AgriSell> getSells() {
        return sells;
    }

    public void setSells(List<AgriSell> sells) {
        this.sells = sells;
    }

    public List<AgriTransport> getTransports() {
        return transports;
    }

    public void setTransports(List<AgriTransport> transports) {
        this.transports = transports;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setPid(String pid) 
    {
        this.pid = pid;
    }

    public String getPid() 
    {
        return pid;
    }
    public void setName(String name)
    {
        this.name = name;
    }

    public String getName()
    {
        return name;
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

    public String getOnlyCode() { return onlyCode; }
    public void setOnlyCode(String onlyCode) { this.onlyCode = onlyCode; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getTp() { return tp; }
    public void setTp(String tp) { this.tp = tp; }

    public String getPlantCity() { return plantCity; }
    public void setPlantCity(String plantCity) { this.plantCity = plantCity; }


    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("pid", getPid())
            //.append("tid", getName())
            .append("name", getName())
            .append("onlyCode", getOnlyCode())
            .append("number", getNumber())
            .append("tp", getTp())
            .append("plantCity", getPlantCity())
            .append("txHash", getTxHash())
            .append("timeStamp", getTimeStamp())
            .append("status", getStatus())
            .toString();
    }


}
