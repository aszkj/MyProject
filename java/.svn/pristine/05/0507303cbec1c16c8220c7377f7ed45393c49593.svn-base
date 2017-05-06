package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 用户抵用券信息表，映射交易域表YiLiDiOrderCenter.T_USER_VOUCHER
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午3:05:15
 */
public class UserVoucher extends BaseModel {

    private static final long serialVersionUID = -8129469760377913305L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 抵用券ID
     */
    private Integer vouId;

    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 批次号
     */
    private String batchNo;

    /**
     * 使用状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERVOUCHERSTATUS)
     */
    private String status;

    /**
     * 使用时间
     */
    private Date useTime;

    /**
     * 活动ID，关联产品域P_ACTIVITY表的ID，表明是由哪种（场）活动给用户产生的抵用券
     */
    private Integer activityId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getVouId() {
        return vouId;
    }

    public void setVouId(Integer vouId) {
        this.vouId = vouId;
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

}