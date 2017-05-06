package com.yilidi.o2o.common;

import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.utils.PropertiesUtils;

/**
 * properties文件读取，初始化参数
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:43:24
 */
public final class InitConfig {

    /**
     * 私有化构造函数
     */
    private InitConfig() {
    }

    /**
     * 系统配置参数
     */
    public static Map<String, String> systemConfigParams = new HashMap<String, String>();
    /**
     * Email消息配置参数
     */
    public static Map<String, String> emailMessageConfigParams = new HashMap<String, String>();
    /**
     * 短信消息配置参数
     */
    public static Map<String, String> smsMessageConfigParams = new HashMap<String, String>();
    /**
     * 推送消息配置参数
     */
    public static Map<String, String> pushMessageConfigParams = new HashMap<String, String>();

    static {
        systemConfigParams = PropertiesUtils.get("config.properties");
        emailMessageConfigParams = PropertiesUtils.get("email-message.properties");
        smsMessageConfigParams = PropertiesUtils.get("sms-message.properties");
        pushMessageConfigParams = PropertiesUtils.get("push-message.properties");
    }
}
