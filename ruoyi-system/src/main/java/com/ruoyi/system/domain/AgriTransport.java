package com.ruoyi.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 运输信息ID对象 agri_transport
 *
 * @author ruoyi
 * @date 2022-12-20
 */
@TableName("agri_transport")
public class AgriTransport extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 运输表的ID */
    @TableId(type = IdType.AUTO)
    private Long id;

    /** 运输信息的上链key */
    @Excel(name = "运输信息的上链key")
    private String tid;

    /** 所运输的商品的上链key */
    @Excel(name = "所运输的商品的上链key")
    private String pid;

    /** 司机姓名 */
    @Excel(name = "司机姓名")
    private String driverName;

    /** 电话号码 */
    @Excel(name = "电话号码")
    private String phone;

    /** 车牌号 */
    @Excel(name = "车牌号")
    private String carNumber;

    /** 商品数量 */
    @Excel(name = "商品数量")
    private String productAmount;

    /** 出发地 */
    @Excel(name = "出发地")
    private String startCity;

    /** 商品规格 */
    @Excel(name = "商品规格")
    private String tp;

    /** 终止地 */
    @Excel(name = "终止地")
    private String endCity;

    /** 开始时间 */
    @Excel(name = "开始时间")
    private String startTime;

    /** 交易哈希 */
    @Excel(name = "交易哈希")
    private String txHash;

    /** 上链时间 */
    @Excel(name = "上链时间")
    private String timeStamp;

    /** 状态: 0-未上链, 1-已上链 */
    @Excel(name = "状态", readConverterExp = "0=未上链,1=已上链")
    private Integer status;

    public AgriTransport() {
    }

    public AgriTransport(String tid, String pid) {
        this.tid = tid;
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
    public void setTid(String tid)
    {
        this.tid = tid;
    }

    public String getTid()
    {
        return tid;
    }
    public void setPid(String pid)
    {
        this.pid = pid;
    }

    public String getPid()
    {
        return pid;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getProductAmount() {
        return productAmount;
    }

    public void setProductAmount(String productAmount) {
        this.productAmount = productAmount;
    }

    public String getStartCity() {
        return startCity;
    }

    public void setStartCity(String startCity) {
        this.startCity = startCity;
    }

    public String getTp() {
        return tp;
    }

    public void setTp(String tp) {
        this.tp = tp;
    }

    public String getEndCity() {
        return endCity;
    }

    public void setEndCity(String endCity) {
        this.endCity = endCity;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
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
                .append("tid", getTid())
                .append("pid", getPid())
                .append("driverName", getDriverName())
                .append("phone", getPhone())
                .append("carNumber", getCarNumber())
                .append("productAmount", getProductAmount())
                .append("startCity", getStartCity())
                .append("tp", getTp())
                .append("endCity", getEndCity())
                .append("startTime", getStartTime())
                .append("txHash", getTxHash())
                .append("timeStamp", getTimeStamp())
                .append("status", getStatus())
                .toString();
    }
}