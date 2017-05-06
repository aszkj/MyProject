package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 用户抢红包信息DTO
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午3:06:02
 */
public class UserRedEnvelopeActivityDto extends BaseDto {

    private static final long serialVersionUID = -5205323864799407073L;

    /**
     * ID
     */
    private Integer id;

    /**
     * 抢红包活动ID
     */
    private Integer redEnvelopeActivityId;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 抢红包次数
     */
    private Integer playCount;

    /**
     * 每天在规定的抢红包次数范围内抢到的红包总个数
     */
    private Integer redEnvelopeCount;

    /**
     * 抢红包日期
     */
    private Date playDate;

    /**
     * 最后抢红包时间
     */
    private Date lastPlayTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRedEnvelopeActivityId() {
        return redEnvelopeActivityId;
    }

    public void setRedEnvelopeActivityId(Integer redEnvelopeActivityId) {
        this.redEnvelopeActivityId = redEnvelopeActivityId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPlayCount() {
        return playCount;
    }

    public void setPlayCount(Integer playCount) {
        this.playCount = playCount;
    }

    public Integer getRedEnvelopeCount() {
        return redEnvelopeCount;
    }

    public void setRedEnvelopeCount(Integer redEnvelopeCount) {
        this.redEnvelopeCount = redEnvelopeCount;
    }

    public Date getPlayDate() {
        return playDate;
    }

    public void setPlayDate(Date playDate) {
        this.playDate = playDate;
    }

    public Date getLastPlayTime() {
        return lastPlayTime;
    }

    public void setLastPlayTime(Date lastPlayTime) {
        this.lastPlayTime = lastPlayTime;
    }

}