package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：保证金变化历史记录实体类，映射用户域表YiLiDiUserCenter.DEPOSIT_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class DepositHistory extends BaseModel {
	private static final long serialVersionUID = -2515663918151238178L;
	/**
	 * 记录ID，自增主键
	 */
	private Integer recordId;
	/**
	 * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
	 */
	private Integer storeId;
	/**
	 * 变化类型编码，系统字典中定义
	 */
	private String changeTypeCode;
	/**
	 * 来源
	 */
	private String source;
	/**
	 * 去向
	 */
	private String target;
	/**
	 * 变化金额
	 */
	private Long amount;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 变化原因
	 */
	private String reason;
	/**
	 * 备注
	 */
	private String note;

	public Integer getRecordId() {
		return recordId;
	}

	public void setRecordId(Integer recordId) {
		this.recordId = recordId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getChangeTypeCode() {
		return changeTypeCode;
	}

	public void setChangeTypeCode(String changeTypeCode) {
		this.changeTypeCode = changeTypeCode;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}