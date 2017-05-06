package com.yilidi.o2o.order.model.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

public class CouponQuery extends BaseQuery {
	private static final long serialVersionUID = 1L;
	
	private Integer conPackId;
	/**
	 * 发放方式
	 */
	private String grantWay;
	/**
	 * 优惠券发放规则说明
	 */
	private String rule;
	/**
	 * 优惠券发放时间（开始字符串）
	 */
	private String strBeginTime;
	/**
	 * 优惠券发放时间（结束字符串）
	 */
	private String strEndTime;
	/**
	 * 优惠券发放时间（开始）
	 */
	private Date beginTime;
	/**
	 * 优惠券发放时间（结束）
	 */
	private Date endTime;

	public String getStrBeginTime() {
		return strBeginTime;
	}

	public void setStrBeginTime(String strBeginTime) {
		this.strBeginTime = strBeginTime;
	}

	public String getStrEndTime() {
		return strEndTime;
	}

	public void setStrEndTime(String strEndTime) {
		this.strEndTime = strEndTime;
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

	public Integer getConPackId() {
		return conPackId;
	}

	public void setConPackId(Integer conPackId) {
		this.conPackId = conPackId;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public String getGrantWay() {
		return grantWay;
	}

	public void setGrantWay(String grantWay) {
		this.grantWay = grantWay;
	}
}
