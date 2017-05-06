package com.yilidi.erp.common;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.utils.PropertiesUtils;

/**
 * properties文件读取，初始化参数
 * 
 * @author: chenlian
 * @date: 2016年12月30日 下午5:06:37
 */
public final class InitConfig {

    /**
     * 私有化构造函数
     */
    private InitConfig() {
    }

    /**
     * webservice配置参数
     */
    public static Map<String, String> webserviceConfigParams = new HashMap<String, String>();

    static {
        webserviceConfigParams = PropertiesUtils.get("webservice.properties");
    }
}
