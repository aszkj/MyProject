package com.yilidi.o2o.appvo.buyer.system;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.core.connect.config.WechatConfig;

/**
 * 微信SDK签名相关信息
 */
public class WXSdkSign extends AppBaseVO {

	/**
	 * 
	 */
	private String appId;

	private Long timestamp;

	private String nonceStr;

	private String signature; // SHA1签名

	public WXSdkSign(Long timestamp, String nonceStr, String signature) {
		super();
		setAppId(WechatConfig.getAppId(true));
		setTimestamp(timestamp);
		setNonceStr(nonceStr);
		setSignature(signature);
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public Long getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(Long timestamp) {
		this.timestamp = timestamp;
	}

	public String getNonceStr() {
		return nonceStr;
	}

	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

}
