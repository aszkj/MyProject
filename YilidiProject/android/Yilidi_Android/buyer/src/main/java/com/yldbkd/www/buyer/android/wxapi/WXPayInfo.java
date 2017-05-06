package com.yldbkd.www.buyer.android.wxapi;

import com.yldbkd.www.buyer.android.bean.BaseModel;

/**
 * 微信支付所需组装信息
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class WXPayInfo extends BaseModel {
    /**
     * 公众账号ID:微信分配的公众账号ID
     */
    public String appId;
    /**
     * 商户号:微信支付分配的商户号
     */
    public String partnerId;
    /**
     * 预支付交易会话ID:微信返回的支付交易会话ID
     */
    public String prepayId;
    /**
     * 随机字符串:随机字符串，不长于32位。
     */
    public String nonceStr;
    /**
     * 时间戳:
     */
    public String timeStamp;
    /**
     * 扩展字段:"Sign=WXPay"--默认
     */
    public String packageValue;
    /**
     * 签名
     */
    public String sign;

    public String getAppId() {
        return appId;
    }

    public void setAppId(String appId) {
        this.appId = appId;
    }

    public String getPartnerId() {
        return partnerId;
    }

    public void setPartnerId(String partnerId) {
        this.partnerId = partnerId;
    }

    public String getPrepayId() {
        return prepayId;
    }

    public void setPrepayId(String prepayId) {
        this.prepayId = prepayId;
    }

    public String getNonceStr() {
        return nonceStr;
    }

    public void setNonceStr(String nonceStr) {
        this.nonceStr = nonceStr;
    }

    public String getTimeStamp() {
        return timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getPackageValue() {
        return packageValue;
    }

    public void setPackageValue(String packageValue) {
        this.packageValue = packageValue;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

}
