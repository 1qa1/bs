package com.ruoyi.system.utils;

import java.util.UUID;

public class GenerateUUID {

    public static String Generate(){
        return UUID.randomUUID().toString();
    }
}
