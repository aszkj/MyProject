package com.yilidi.o2o.core.connect.qq.javabean;

import java.io.Serializable;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;

public class QQUserInfo implements Serializable {
    private static final long serialVersionUID = -8234838171917073910L;

    private Logger logger = Logger.getLogger(this.getClass());

    private String nickname;
    private String headimgurl;
    private String gender;
    private boolean vip;
    private int level;
    private boolean yellowYearVip;
    private int ret;
    private String msg;

    public QQUserInfo(String jsonStr) {
        JSONObject resultMap = JsonUtils.parseObject(jsonStr);
        try {
            this.ret = resultMap.getIntValue("ret");
            if (0 != this.ret) {
                this.msg = resultMap.getString("msg");
            } else {
                this.nickname = StringUtils.removeNonBmpUnicode(resultMap.getString("nickname"));
                this.gender = resultMap.getString("gender");
                this.vip = (resultMap.getIntValue("vip") == 1);
                String headimgurl = resultMap.getString("figureurl_qq_2");
                if (StringUtils.isEmpty(headimgurl)) {
                    headimgurl = resultMap.getString("figureurl_qq_1");
                }
                this.headimgurl = headimgurl;
                this.yellowYearVip = (resultMap.getIntValue("is_yellow_year_vip") == 1);
                this.level = resultMap.getIntValue("level");
            }
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage() + ":" + resultMap.toString(), e);
        }
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeadimgurl() {
        return headimgurl;
    }

    public void setHeadimgurl(String headimgurl) {
        this.headimgurl = headimgurl;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean isVip() {
        return vip;
    }

    public void setVip(boolean vip) {
        this.vip = vip;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public boolean isYellowYearVip() {
        return yellowYearVip;
    }

    public void setYellowYearVip(boolean yellowYearVip) {
        this.yellowYearVip = yellowYearVip;
    }

    public int getRet() {
        return ret;
    }

    public void setRet(int ret) {
        this.ret = ret;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

}
