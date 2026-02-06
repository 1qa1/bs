package com.ruoyi.system.domain;

import com.ruoyi.common.annotation.Excel;
import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AgriBCRoutineCheck {
    @Excel(name = "上链ID")
    private String ID;
    @Excel(name = "检查时间")
    private String CheckTime;
    @Excel(name = "检查项目")
    private String CheckName;
    @Excel(name = "检查问题")
    private String Problems;
    @Excel(name = "建议")
    private String Proposal;
    @Excel(name = "参与人员")
    private String OrgMember;
    @Excel(name = "报告上传URL")
    private String UploadsUrl;

    @Excel(name = "所属商品")
    private String Pid;

    @Excel(name="上链的交易Hash")
    private String TxHash;
    @Excel(name = "上链时间戳")
    private String timeStamp;
}
