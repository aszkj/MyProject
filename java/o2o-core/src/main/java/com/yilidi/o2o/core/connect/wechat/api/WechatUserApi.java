package com.yilidi.o2o.core.connect.wechat.api;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.yilidi.o2o.core.connect.wechat.javabean.AccessToken;
import com.yilidi.o2o.core.connect.wechat.javabean.WechatUserInfo;
import com.yilidi.o2o.core.utils.HttpUtils;

public class WechatUserApi {
	private static final String GETUSERINFO_URL = "https://api.weixin.qq.com/sns/userinfo";

	/**
	 * 获取用户个人信
	 * 
	 * @param accessToken
	 *            调用凭证access_token
	 * @param openId
	 *            普通用户的标识，对当前开发者帐号唯一
	 * @return WechatUserInfo
	 * @throws IOException
	 */
	public static WechatUserInfo getUserInfo(String accessToken, String openId) throws IOException {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("access_token", accessToken);
		paramMap.put("openid", openId);
		paramMap.put("lang", "zh_CN");
		return new WechatUserInfo(HttpUtils.doGet(GETUSERINFO_URL, paramMap));
	}

	public static WechatUserInfo getUserInfo(String code, boolean isJsApi) throws IOException {
		AccessToken snsAccessToken = AccessTokenApi.getAccessToken(code, isJsApi);
		return getUserInfo(snsAccessToken.getAccessToken(), snsAccessToken.getOpenid());
	}
}
