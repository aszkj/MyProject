package com.yldbkd.www.buyer.android.bean;

/**
 * 用户抢红包相关活动信息
 * <p>
 * Created by linghuxj on 2016/10/18.
 */

public class UserRedEnvelopeInfo extends BaseModel {

    /**
     * 用户当前活动剩余参与次数
     */
    private Integer residueTimes;
    /**
     * 用户当前活动已抢到的红包个数
     */
    private Integer receivedRedEnvelopeCount;
    /**
     * 红包活动信息
     */
    private RedEnvelopeInfo redEnvelopeActivityInfo;

    public Integer getResidueTimes() {
        return residueTimes;
    }

    public void setResidueTimes(Integer residueTimes) {
        this.residueTimes = residueTimes;
    }

    public Integer getReceivedRedEnvelopeCount() {
        return receivedRedEnvelopeCount;
    }

    public void setReceivedRedEnvelopeCount(Integer receivedRedEnvelopeCount) {
        this.receivedRedEnvelopeCount = receivedRedEnvelopeCount;
    }

    public RedEnvelopeInfo getRedEnvelopeActivityInfo() {
        return redEnvelopeActivityInfo;
    }

    public void setRedEnvelopeActivityInfo(RedEnvelopeInfo redEnvelopeActivityInfo) {
        this.redEnvelopeActivityInfo = redEnvelopeActivityInfo;
    }
}
