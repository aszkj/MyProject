/**
 * 文件名称：AccountTypeInfoDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountTypeInfoDto extends BaseDto {
	private static final long serialVersionUID = -2184893739375023003L;

	/**
	 * 账本类型ID，主键自增长
	 */
	private Integer accountTypeId;
	/**
	 * 账本类型编码, 编码规则： ACCOUT_TYPE_开始，最多36个字符。
	 */
	private String accountTypeCode;
	/**
	 * 账本类型名称
	 */
	private String accountTypeName;
	/**
	 * 支付优先级，用于决定在使用账本支付时，各个账本的支付优先级。级别数值越小，越早支付
	 */
	private Integer payPriority;
	/**
	 * 支付模式。用于定义该账本类型的支付模式。 支付模式： ACCOUNTPAYMODE_FULLPAY：全额支付。即可支付费用单的所有费用，包括产品、运费和其他费用。
	 * ACCOUNTPAYMODE_PERCENTPAY：产品比例支付。即可支付产品费用单的一定比例的费用。不包括运费和其他费用。
	 * ACCOUNTPAYMODE_COUNTPAY：产品礼券支付。即可通过礼金券支付产品费用。不包括运费和其他费用。
	 */
	private String payMode;
	/**
	 * 支付比例。用于决定在使用该账本支付时，本账本可支付的订单金额的比例。本字段的取值范围为[1,100]。 1、支付模式为ACCOUNTPAYMODE_FULLPAY时，默认这项值为100；
	 * 2、支付模式为ACCOUNTPAYMODE_PERCENTPAY时，填入的数值范围为比例。如：支付比例为30，则本账本在用于支付订单金额的总金额的比例为30%。订单金额为1000元，则本账本可以用于支付的费用最多只能为300元。
	 * 3、支付模式为ACCOUNTPAYMODE_COUNTPAY时，填入的数值为每个支付费用单最多可使用的礼券数量。如：填入PAY_SCALE数值为2时
	 */
	private Integer payScale;
	/**
	 * 创建人的ID
	 */
	private Integer createUserId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 修改人
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 备注
	 */
	private String note;

	public Integer getAccountTypeId() {
		return accountTypeId;
	}

	public void setAccountTypeId(Integer accountTypeId) {
		this.accountTypeId = accountTypeId;
	}

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}

	public String getAccountTypeName() {
		return accountTypeName;
	}

	public void setAccountTypeName(String accountTypeName) {
		this.accountTypeName = accountTypeName;
	}

	public Integer getPayPriority() {
		return payPriority;
	}

	public void setPayPriority(Integer payPriority) {
		this.payPriority = payPriority;
	}

	public String getPayMode() {
		return payMode;
	}

	public void setPayMode(String payMode) {
		this.payMode = payMode;
	}

	public Integer getPayScale() {
		return payScale;
	}

	public void setPayScale(Integer payScale) {
		this.payScale = payScale;
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

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	/**
	 * 功能描述：账户类型定义内部类 <br/>
	 * 作者：chenl <br/>
	 * 
	 * BugID: <br/>
	 * 修改内容： <br/>
	 */
	public static final class Type {
		/**
		 * 余额账户
		 */
		public static final String YE = "ACCOUNT_TYPE_YE";

		/**
		 * 保价返利账户
		 */
		public static final String BJ = "ACCOUNT_TYPE_BJ";
	}
}
