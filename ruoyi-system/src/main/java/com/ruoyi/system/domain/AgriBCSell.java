package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.system.domain.AgriSell;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCSell  {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "到达时间")
    private String ArrivalTime;
    @Excel(name = "售卖数量")
    private String Amount;
    @Excel(name = "售卖规格")
    //private String TP;
    private String Tp;
    @Excel(name = "检疫时间")
    private String CheckTime;
    @Excel(name = "检疫项目")
    private String CheckName;
    @Excel(name = "检疫结果")
    private String CheckResult;
    @Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
