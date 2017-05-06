package com.yilidi.o2o.core.connect.qq.api;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.connect.config.QQConfig;
import com.yilidi.o2o.core.connect.qq.javabean.QQUserInfo;
import com.yilidi.o2o.core.utils.HttpUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;

public class QQUserInfoApi {
    /**
     * 获取qq用户信息接口地址
     */
    private static final String GETUSERINFO_URL = "https://graph.qq.com/user/get_user_info";

    /**
     * 获取用户个人信
     * 
     * @param accessToken
     *            调用凭证access_token
     * @param openId
     *            普通用户的标识，对当前开发者帐号唯一
     * @param type
     *            类型,1-android,2-ios,3-网站,默认网站
     * @return QQUserInfo
     * @throws IOException
     */
    public static QQUserInfo getUserInfo(String accessToken, String openId, String type) throws IOException {
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("access_token", accessToken);
        paramMap.put("openid", openId);
        paramMap.put("oauth_consumer_key", getAppIdByType(type));
        paramMap.put("lang", "zh_CN");
        return new QQUserInfo(HttpUtils.doGet(GETUSERINFO_URL, paramMap));
    }

    /**
     * 获取用户个人信
     * 
     * @param accessToken
     *            调用凭证access_token
     * @param openId
     *            普通用户的标识，对当前开发者帐号唯一
     * @return QQUserInfo
     * @throws IOException
     */
    public static QQUserInfo getUserInfoForIos(String accessToken, String openId) throws IOException {
        return getUserInfo(accessToken, openId, "2");
    }

    /**
     * 获取用户个人信
     * 
     * @param accessToken
     *            调用凭证access_token
     * @param openId
     *            普通用户的标识，对当前开发者帐号唯一
     * @return QQUserInfo
     * @throws IOException
     */
    public static QQUserInfo getUserInfoForAndroid(String accessToken, String openId) throws IOException {
        return getUserInfo(accessToken, openId, "1");
    }

    /**
     * 获取用户个人信
     * 
     * @param accessToken
     *            调用凭证access_token
     * @param openId
     *            普通用户的标识，对当前开发者帐号唯一
     * @return QQUserInfo
     * @throws IOException
     */
    public static QQUserInfo getUserInfoForPc(String accessToken, String openId) throws IOException {
        return getUserInfo(accessToken, openId, "3");
    }

    private static String getAppIdByType(String type) {
        if (ObjectUtils.isNullOrEmpty(type)) {
            return QQConfig.APP_ID_FORPC;
        }
        switch (type) {
        case "1":
            return QQConfig.APP_ID_FORANDROID;
        case "2":
            return QQConfig.APP_ID_FORIOS;
        default:
            return QQConfig.APP_ID_FORPC;
        }
    }
}
