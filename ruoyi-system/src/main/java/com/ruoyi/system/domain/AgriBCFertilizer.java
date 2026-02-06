package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.system.domain.AgriFertilizer;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCFertilizer  {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "肥料名称")
    private String Name;
    @Excel(name = "肥料公司")
    private String Company;
    @Excel(name = "生产批号")
    private String BatchNo;
    @Excel(name = "使用时间")
    private String UseTime;

//    装载pid
@Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
