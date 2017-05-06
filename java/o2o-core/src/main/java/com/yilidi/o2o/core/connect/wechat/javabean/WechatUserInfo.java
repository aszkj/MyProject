package com.yilidi.o2o.core.connect.wechat.javabean;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;

public class WechatUserInfo implements Serializable {
    private static Logger logger = Logger.getLogger(WechatUserInfo.class);
    private static final long serialVersionUID = 8217361439655836738L;

    private String openid;
    private String nickname;
    private int sex;
    private String province;
    private String city;
    private String country;
    private String headimgurl;
    private String unionid;
    private String errcode; // 出错时有值
    private String errmsg; // 出错时有值

    public WechatUserInfo(String jsonStr) {
        JSONObject resultMap = JsonUtils.parseObject(jsonStr);
        this.openid = resultMap.getString("openid");
        this.nickname = StringUtils.removeNonBmpUnicode(resultMap.getString("nickname"));
        this.sex = resultMap.getIntValue("sex");
        this.province = resultMap.getString("province");
        this.city = resultMap.getString("city");
        this.country = resultMap.getString("country");
        this.headimgurl = resultMap.getString("headimgurl");
        this.unionid = resultMap.getString("unionid");
        this.errcode = resultMap.getString("errcode");
        this.errmsg = resultMap.getString("errmsg");
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getHeadimgurl() {
        return headimgurl;
    }

    public void setHeadimgurl(String headimgurl) {
        this.headimgurl = headimgurl;
    }

    public String getUnionid() {
        return unionid;
    }

    public void setUnionid(String unionid) {
        this.unionid = unionid;
    }

    public String getErrcode() {
        return errcode;
    }

    public void setErrcode(String errcode) {
        this.errcode = errcode;
    }

    public String getErrmsg() {
        return errmsg;
    }

    public void setErrmsg(String errmsg) {
        this.errmsg = errmsg;
    }

}
