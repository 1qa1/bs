package com.ruoyi.system.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AgriMergeResult {

    private AgriBCProduct product;
    private List<AgriBCCheck> check;
    private List<AgriBCFertilizer> fertilizer;
    private List<AgriBCGrow> grow;
    private List<AgriBCMedicine> medicine;
    private List<AgriBCOfficialCheck> officialCheck;
    private List<AgriBCRoutineCheck> routineCheck;
    private List<AgriBCSell> sell;
    private List<AgriBCTransport> transport;

}
