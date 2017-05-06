package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 抢红包活动相关基本信息DTO
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午4:42:56
 */
public class RedEnvelopeActivityInfoDto extends BaseDto {

    private static final long serialVersionUID = -5818403015244900714L;

    /**
     * 抢红包活动ID
     */
    private Integer id;

    /**
     * 抢红包活动名称
     */
    private String activityName;

    /**
     * 调用请求几率
     */
    private Integer invokeProbability;

    /**
     * 有效期开始时间
     */
    private Date validStartTime;

    /**
     * 有效期结束时间
     */
    private Date validEndTime;

    /**
     * 活动规则说明
     */
    private String rule;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 抢红包活动状态
     */
    private String status;

    /**
     * 抢红包活动状态名称
     */
    private String statusName;

    /**
     * 红包奖励列表信息
     */
    private List<RedEnvelopeRewardDto> redEnvelopeRewards;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public Integer getInvokeProbability() {
        return invokeProbability;
    }

    public void setInvokeProbability(Integer invokeProbability) {
        this.invokeProbability = invokeProbability;
    }

    public Date getValidStartTime() {
        return validStartTime;
    }

    public void setValidStartTime(Date validStartTime) {
        this.validStartTime = validStartTime;
    }

    public Date getValidEndTime() {
        return validEndTime;
    }

    public void setValidEndTime(Date validEndTime) {
        this.validEndTime = validEndTime;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public List<RedEnvelopeRewardDto> getRedEnvelopeRewards() {
        return redEnvelopeRewards;
    }

    public void setRedEnvelopeRewards(List<RedEnvelopeRewardDto> redEnvelopeRewards) {
        this.redEnvelopeRewards = redEnvelopeRewards;
    }

}