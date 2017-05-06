package com.yilidi.o2o.appvo.buyer.pay;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 微信支付订单参数
 * 
 * @author simpson
 * 
 */
public class WxPayAppOrderParamVO extends AppBaseVO {

    private static final long serialVersionUID = -8664905810291011360L;

    /**
     * 公众账号ID
     */
    private String appId;
    /**
     * 商户号
     */
    private String partnerId;
    /**
     * 预支付交易会话ID
     */
    private String prepayId;
    /**
     * 随机字符串
     */
    private String nonceStr;
    /**
     * 时间戳
     */
    private String timeStamp;
    /**
     * 扩展字段：默认“Sign=WXPay”
     */
    private String packageValue;
    /**
     * 签名
     */
    private String sign;

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
