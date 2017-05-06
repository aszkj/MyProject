package com.yldbkd.www.seller.android.wxapi;

import com.yldbkd.www.seller.android.bean.BaseModel;

/**
 * 微信支付所需组装信息
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class WXPayInfo extends BaseModel {
    /**
     * 公众账号ID:微信分配的公众账号ID
     */
    public String appid;
    /**
     * 商户号:微信支付分配的商户号
     */
    public String partnerid;
    /**
     * 预支付交易会话ID:微信返回的支付交易会话ID
     */
    public String prepayid;
    /**
     * 随机字符串:随机字符串，不长于32位。
     */
    public String noncestr;
    /**
     * 时间戳:
     */
    public String timestamp;
    /**
     * 扩展字段:"Sign=WXPay"--默认
     */
    public String packagevalue;
    /**
     * 签名
     */
    public String sign;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getPartnerid() {
        return partnerid;
    }

    public void setPartnerid(String partnerid) {
        this.partnerid = partnerid;
    }

    public String getPrepayid() {
        return prepayid;
    }

    public void setPrepayid(String prepayid) {
        this.prepayid = prepayid;
    }

    public String getNoncestr() {
        return noncestr;
    }

    public void setNoncestr(String noncestr) {
        this.noncestr = noncestr;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getPackagevalue() {
        return packagevalue;
    }

    public void setPackagevalue(String packagevalue) {
        this.packagevalue = packagevalue;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

}
