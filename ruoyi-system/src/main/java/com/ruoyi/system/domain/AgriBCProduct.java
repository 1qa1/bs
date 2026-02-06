package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.system.domain.AgriProduct;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCProduct  {
    @Excel(name = "产品ID")
    private String ID;
    @Excel(name = "产品名")
    private String ProductName;
    @Excel(name = "种植数量")
    private int Number;
    @Excel(name = "规格")
    private String TP;
    @Excel(name = "种植地")
    private String PlantCity;
    @Excel(name = "产品唯一编码")
    private String OnlyCode;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;



}
