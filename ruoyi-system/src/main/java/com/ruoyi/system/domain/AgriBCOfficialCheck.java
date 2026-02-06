package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import lombok.Data;

@Data
public class AgriBCOfficialCheck {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "检查时间")
    private String ReportTime;
    @Excel(name = "检查结果")
    private String ReportResult;
    @Excel(name = "报告上传URL")
    private String ReportUploadsUrl;
    @Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
