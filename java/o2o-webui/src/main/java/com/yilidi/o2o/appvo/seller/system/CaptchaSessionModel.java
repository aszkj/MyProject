package com.yilidi.o2o.appvo.seller.system;

import java.util.Date;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(验证码Session封装类)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class CaptchaSessionModel extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;
    /**
     * 验证码
     */
    private String captcha;
    /**
     * 发送验证码时间
     */
    private Date sendTime;

    public String getCaptcha() {
        return captcha;
    }

    public void setCaptcha(String captcha) {
        this.captcha = captcha;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

}
