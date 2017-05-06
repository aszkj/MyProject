package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 用户优惠券信息表，映射交易域表YiLiDiOrderCenter.T_USER_COUPON
 * 
 * @author: chenlian
 * @date: 2016年10月19日 上午10:22:40
 */
public class UserCoupon extends BaseModel {

    private static final long serialVersionUID = -8129469760377913305L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 优惠券ID
     */
    private Integer conId;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 使用状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERCOUPONSSTATUS)
     */
    private String status;

    /**
     * 使用时间
     */
    private Date useTime;

    /**
     * 活动ID，关联产品域P_ACTIVITY表的ID，表明是由哪种（场）活动给用户产生的优惠券
     */
    private Integer activityId;
    
    /**
     * 优惠券发放批次号
     */
    private String batchNo;
    /**
     * 优惠券使用开始时间
     */
    private Date beginTime;
    /**
     * 优惠券使用结束时间
     */
    private Date endTime;
    /**
     * 优惠券领取时间
     */
    private Date findTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getConId() {
        return conId;
    }

    public void setConId(Integer conId) {
        this.conId = conId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getFindTime() {
		return findTime;
	}

	public void setFindTime(Date findTime) {
		this.findTime = findTime;
	}

}