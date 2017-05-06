package com.yilidi.o2o.order.model.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

public class VoucherQuery extends BaseQuery {
	private static final long serialVersionUID = 1L;
	/**
	 * 券包id
	 */
	private Integer vouPackId;
	/**
	 * 规则说明
	 */
	private String rule;
	/**
     * 发放时间(開始)
     */
    private Date granBeginTime;
    /**
     * 发放时间(開始)
     */
    private Date granEndTime;
    /**
     * 发放时间(開始str)
     */
    private Date strGranBeginTime;
    /**
     * 发放时间(開始str)
     */
    private Date strGranEndTime;
	public Integer getVouPackId() {
		return vouPackId;
	}
	public void setVouPackId(Integer vouPackId) {
		this.vouPackId = vouPackId;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public Date getGranBeginTime() {
		return granBeginTime;
	}
	public void setGranBeginTime(Date granBeginTime) {
		this.granBeginTime = granBeginTime;
	}
	public Date getGranEndTime() {
		return granEndTime;
	}
	public void setGranEndTime(Date granEndTime) {
		this.granEndTime = granEndTime;
	}
	public Date getStrGranBeginTime() {
		return strGranBeginTime;
	}
	public void setStrGranBeginTime(Date strGranBeginTime) {
		this.strGranBeginTime = strGranBeginTime;
	}
	public Date getStrGranEndTime() {
		return strGranEndTime;
	}
	public void setStrGranEndTime(Date strGranEndTime) {
		this.strGranEndTime = strGranEndTime;
	}
}
