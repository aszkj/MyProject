package com.yilidi.o2o.system.push.getui;

import com.yilidi.o2o.common.InitConfig;

public class ApplyPushGetuiParam {
    private String appId;

    private String appKey;

    private String masterSecret;

	private String url;
    
	private String signature;
	
	public ApplyPushGetuiParam(String appId, String appKey, String masterSecret, String url, String signature) {
		this.appId = appId;
		this.appKey = appKey;
		this.masterSecret = masterSecret;
		this.url = url;
		this.signature = signature;
	}
	
	public static ApplyPushGetuiParam getBuyerInstance(){
		return BuyerApplyInstance.BUYERINSTANCE;
	}
	public static ApplyPushGetuiParam getSellerInstance(){
		return SellerApplyInstance.SELLERINSTANCE;
	}
	private static class BuyerApplyInstance{
		private static final String APPID = InitConfig.pushMessageConfigParams.get("buyer.push.getui.appId");
		private static final String APPKEY = InitConfig.pushMessageConfigParams.get("buyer.push.getui.appKey");
		private static final String MASTERSECRET = InitConfig.pushMessageConfigParams.get("buyer.push.getui.masterSecret") ;
		private static final String URL = InitConfig.pushMessageConfigParams.get("push.getui.url");
		private static final String SIGNATURE = InitConfig.pushMessageConfigParams.get("push.getui.signature");
		private static final ApplyPushGetuiParam BUYERINSTANCE = new ApplyPushGetuiParam(APPID, APPKEY, MASTERSECRET, URL, SIGNATURE);
	}
	private static class SellerApplyInstance{
		private static final String APPID = InitConfig.pushMessageConfigParams.get("buyer.push.getui.appId");
		private static final String APPKEY = InitConfig.pushMessageConfigParams.get("buyer.push.getui.appKey");
		private static final String MASTERSECRET = InitConfig.pushMessageConfigParams.get("buyer.push.getui.masterSecret") ;
		private static final String URL = InitConfig.pushMessageConfigParams.get("push.getui.url");
		private static final String SIGNATURE = InitConfig.pushMessageConfigParams.get("push.getui.signature");
		private static final ApplyPushGetuiParam SELLERINSTANCE = new ApplyPushGetuiParam(APPID, APPKEY, MASTERSECRET, URL, SIGNATURE);
	}

	public String getAppId() {
		return appId;
	}

	public String getAppKey() {
		return appKey;
	}

	public String getMasterSecret() {
		return masterSecret;
	}

	public String getUrl() {
		return url;
	}

	public String getSignature() {
		return signature;
	}
}
