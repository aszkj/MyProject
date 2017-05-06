package com.yilidi.o2o.product.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 抢红包活动相关基本信息
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午4:40:35
 */
public class RedEnvelopeActivityInfo extends BaseModel {

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
     * 有效期开始时间
     */
    private Date validStartTime;

    /**
     * 有效期结束时间
     */
    private Date validEndTime;

    /**
     * 创建时间
     */
    private Date createTime;

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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}