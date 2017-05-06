package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 优惠券基础信息DTO
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午6:42:46
 */
public class CouponBasicInfoDto extends BaseDto {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * 优惠券ID
     */
    private Integer conId;

    /**
     * 优惠券名称
     */
    private String conName;
    
    /**
     * 优惠券发放时间
     */
    private Date grantTime;
    
    /**
     * 优惠券发放批次号
     */
    private String batchNo;
    
    /**
     * 优惠券发放阶段号
     */
    private Integer stageNo;

    public Integer getConId() {
        return conId;
    }

    public void setConId(Integer conId) {
        this.conId = conId;
    }

    public String getConName() {
        return conName;
    }

    public void setConName(String conName) {
        this.conName = conName;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public Integer getStageNo() {
		return stageNo;
	}

	public void setStageNo(Integer stageNo) {
		this.stageNo = stageNo;
	}

}
