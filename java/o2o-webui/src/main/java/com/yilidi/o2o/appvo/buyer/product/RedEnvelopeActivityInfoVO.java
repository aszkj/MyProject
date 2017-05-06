package com.yilidi.o2o.appvo.buyer.product;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 红包活动规则信息VO
 * 
 * @author: chenlian
 * @date: 2016年11月11日 下午4:54:11
 */
public class RedEnvelopeActivityInfoVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 活动ID
     */
    private Integer activityId;

    /**
     * 活动规则描述
     */
    private String activityRule;

    /**
     * 当前活动最多每日参与次数
     */
    private Integer maxJoinTimes;

    /**
     * 每次抢红包的最大时间
     */
    private Integer maxTimePerTimes;

    /**
     * 每次抢红包的最大总数量
     */
    private Integer maxCountPerTimes;

    /**
     * 接口调用几率（为百分比的单位：0-100）
     */
    private Integer interfaceInvokedProbability;

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public String getActivityRule() {
        return activityRule;
    }

    public void setActivityRule(String activityRule) {
        this.activityRule = activityRule;
    }

    public Integer getMaxJoinTimes() {
        return maxJoinTimes;
    }

    public void setMaxJoinTimes(Integer maxJoinTimes) {
        this.maxJoinTimes = maxJoinTimes;
    }

    public Integer getMaxTimePerTimes() {
        return maxTimePerTimes;
    }

    public void setMaxTimePerTimes(Integer maxTimePerTimes) {
        this.maxTimePerTimes = maxTimePerTimes;
    }

    public Integer getMaxCountPerTimes() {
        return maxCountPerTimes;
    }

    public void setMaxCountPerTimes(Integer maxCountPerTimes) {
        this.maxCountPerTimes = maxCountPerTimes;
    }

    public Integer getInterfaceInvokedProbability() {
        return interfaceInvokedProbability;
    }

    public void setInterfaceInvokedProbability(Integer interfaceInvokedProbability) {
        this.interfaceInvokedProbability = interfaceInvokedProbability;
    }

}
