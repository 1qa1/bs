package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;
import com.ruoyi.system.domain.AgriCheck;
import lombok.Data;

@Data
public class AgriBCCheck extends BaseEntity {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "检查项目")
    private String ProjName;
    @Excel(name = "检查类型")
    private String Types;
    @Excel(name = "检查结果")
    private String Result;
    @Excel(name = "报告上传链接")
    private String UploadsUrl;


//    接受来自前台的pid
    @Excel(name = "所属商品")
    private String pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
