package com.yldbkd.www.seller.android.bean;

/**
 * 发送验证码返回倒计时间
 * <p/>
 * Created by linghuxj on 16/6/29.
 */
public class CaptchaTime extends BaseModel {

    /**
     * 剩余时间，单位秒
     */
    private Integer remainClock;

    public Integer getRemainClock() {
        return remainClock;
    }

    public void setRemainClock(Integer remainClock) {
        this.remainClock = remainClock;
    }
}
