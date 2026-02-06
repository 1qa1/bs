package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.system.domain.AgriTransport;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCTransport {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "司机姓名")
    private String DriverName;
    @Excel(name = "电话号码")
    private String Phone;
    @Excel(name = "车牌号")
    private String CarNumber;
    @Excel(name = "出发地")
    private String StartCity;
    @Excel(name = "终点地")
    private String EndCity;
    @Excel(name = "运输时间")
    private String StartTime;
    @Excel(name = "商品数量")
    private String ProductAmount;
    @Excel(name = "商品规格")
    //private String TP;
    private String Tp;
    @Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
