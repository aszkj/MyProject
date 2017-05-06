package com.yilidi.o2o.appvo.seller.system;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(验证码)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class CaptchaVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(用一句话描述这个变量表示什么)
     */
    private static final long serialVersionUID = -7050180119041902385L;
    /**
     * 剩余倒数计时秒数
     */
    private Integer remainClock;

    public CaptchaVO(Integer remainClock) {
        this.remainClock = remainClock;
    }

    public Integer getRemainClock() {
        return remainClock;
    }

    public void setRemainClock(Integer remainClock) {
        this.remainClock = remainClock;
    }
}
