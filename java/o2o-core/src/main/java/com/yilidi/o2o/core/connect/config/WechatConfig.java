package com.yilidi.o2o.core.connect.config;

import com.yilidi.o2o.core.connect.wechat.cache.IAccessTokenCache;
import com.yilidi.o2o.core.connect.wechat.cache.IJsapiTicketCache;
import com.yilidi.o2o.core.connect.wechat.cache.RedisAccessTokenCache;
import com.yilidi.o2o.core.connect.wechat.cache.RedisJsapiTicketCache;

public class WechatConfig {

	public static final String JS_TRADE_TYPE = "JSAPI";
	/**
	 * 微信appID
	 */
	private static final String APP_ID = "wxadf10b780467d1f7";
	private static final String PUBLISH_APP_ID = "wx2a7706db5d469293";
	/**
	 * 微信密钥
	 */
	private static final String APP_SECRET = "84f6e5434034547a3e9b971e5209d43b";
	private static final String PUBLISH_APP_SECRET = "f3b6d3578d7fc86f583da3484444812f";

	static IAccessTokenCache accessTokenCache = new RedisAccessTokenCache();

	static IJsapiTicketCache jsapiTicketCache = new RedisJsapiTicketCache();

	public static void setAccessTokenCache(IAccessTokenCache accessTokenCache) {
		WechatConfig.accessTokenCache = accessTokenCache;
	}

	public static IAccessTokenCache getAccessTokenCache() {
		return WechatConfig.accessTokenCache;
	}

	public static IJsapiTicketCache getJsapiTicketCache() {
		return jsapiTicketCache;
	}

	public static void setJsapiTicketCache(IJsapiTicketCache jsapiTicketCache) {
		WechatConfig.jsapiTicketCache = jsapiTicketCache;
	}

	public static String getAppId(boolean isJsApi) {
		return isJsApi ? PUBLISH_APP_ID : APP_ID;
	}

	public static String getAppSecret(boolean isJsApi) {
		return isJsApi ? PUBLISH_APP_SECRET : APP_SECRET;
	}
}