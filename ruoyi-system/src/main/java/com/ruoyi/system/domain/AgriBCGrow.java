package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCGrow {

    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "种植时间")
    private String PlantTime;
    @Excel(name = "收获时间")
    private String ReapTime;

//    接受pid
    @Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
