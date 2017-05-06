package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 用户优惠券信息DTO
 * 
 * @author: chenlian
 * @date: 2016年10月26日 上午10:21:39
 */
public class UserCouponInfoDto extends BaseDto {

    private static final long serialVersionUID = -1947534457408931324L;
    /**
     * 用户优惠券ID
     */
    private Integer userCouponId;
    /**
     * 优惠券ID
     */
    private Integer conId;

    /**
     * 优惠券/券包名称
     */
    private String conName;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 用户手机号
     */
    private String phone;

    /**
     * 优惠券使用状态
     */
    private String status;

    /**
     * 优惠券使用状态名称
     */
    private String statusName;

    /**
     * 优惠券面值 单位 厘
     */
    private Long amount;

    /**
     * 优惠券使用条件(单笔订单金额满X元) 单位 厘
     */
    private Long useCondition;

    /**
     * 使用范围编码
     */
    private String useRangeCode;

    /**
     * 使用范围编码名称
     */
    private String useRangeCodeName;

    /**
     * 使用范围
     */
    private String useRange;

    /**
     * 使用范围名称
     */
    private String useRangeName;

    /**
     * 发放时间
     */
    private Date grantTime;

    /**
     * 使用时间
     */
    private Date useTime;
    /**
     * 使用规则
     */
    private String rule;
    /**
     * 订单能否使用该奖券：（前端需要根据该字段进行重新排序） 0：不能使用 1：能使用
     */
    private Integer wouldUse;
    /**
     * 能使用优惠券条件的商品ID列表
     */
    private List<Integer> saleProductIds;
    /**
     * 优惠券领取时间
     */
    private Date findTime;
    /**
     * 有效期开始时间
     */
    private Date beginTime;
    /**
     * 有效期结束时间
     */
    private Date endTime;

    public Integer getUserCouponId() {
        return userCouponId;
    }

    public void setUserCouponId(Integer userCouponId) {
        this.userCouponId = userCouponId;
    }

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Long getUseCondition() {
        return useCondition;
    }

    public void setUseCondition(Long useCondition) {
        this.useCondition = useCondition;
    }

    public String getUseRangeCode() {
        return useRangeCode;
    }

    public void setUseRangeCode(String useRangeCode) {
        this.useRangeCode = useRangeCode;
    }

    public String getUseRangeCodeName() {
        return useRangeCodeName;
    }

    public void setUseRangeCodeName(String useRangeCodeName) {
        this.useRangeCodeName = useRangeCodeName;
    }

    public String getUseRange() {
        return useRange;
    }

    public void setUseRange(String useRange) {
        this.useRange = useRange;
    }

    public String getUseRangeName() {
        return useRangeName;
    }

    public void setUseRangeName(String useRangeName) {
        this.useRangeName = useRangeName;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public Integer getWouldUse() {
        return wouldUse;
    }

    public void setWouldUse(Integer wouldUse) {
        this.wouldUse = wouldUse;
    }

    public List<Integer> getSaleProductIds() {
        return saleProductIds;
    }

    public void setSaleProductIds(List<Integer> saleProductIds) {
        this.saleProductIds = saleProductIds;
    }

	public Date getFindTime() {
		return findTime;
	}

	public void setFindTime(Date findTime) {
		this.findTime = findTime;
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

}
