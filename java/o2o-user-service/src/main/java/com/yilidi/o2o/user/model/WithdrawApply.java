package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：用户取款申请记录实体类，映射用户域表YiLiDiUserCenter.U_WITHDRAW <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class WithdrawApply extends BaseModel {
	private static final long serialVersionUID = 4190384434617767430L;
	/**
	 * 申请ID，自增主键
	 */
	private Integer applyId;
	/**
	 * 账户类型编码
	 */
	private String accountTypeCode;
	/**
	 * 客户ID
	 */
	private Integer customerId;
	/**
	 * 客户类型
	 */
	private String customerType;
	/**
	 * 申请提现金额
	 */
	private Long amount;
	/**
	 * 账户当前可提现余额，单位 厘(记录申请提现当前账本可提现金额，冗余字段）
	 * 账本可提现余额=账本可提现总金额（现金+商品补贴+优惠券补贴）-提现中金额
	 */
	private Long currentBalance;
	/**
	 * 统计用户当提现时，已提现总金额
	 */
	private Long haveWithdraw;
	/**
	 * 现金账本提现扣除金额
	 */
	private Long cashSubsidyAmount;
	/**
	 * 商品补贴扣除金额
	 */
	private Long priceSubsidyAmount;
	/**
	 * 优惠券补贴扣除金额
	 */
	private Long couponSubsidyAmount;
	/**
	 * 申请用户ID
	 */
	private Integer applyUserId;
	/**
	 * 申请时间
	 */
	private Date applyTime;
	/**
	 * 审核用户id
	 */
	private Integer auditUserId;
	/**
	 * 审核时间
	 */
	private Date auditTime;
	/**
	 * 状态编码
	 */
	private String statusCode;
	/**
	 * 审核意见
	 */
	private String auditNote;
	/**
	 * 打款时间
	 */
	private Date transferTime;
	/**
	 * 打款绑定的账户Id，关联U_ACCOUNT_BINDING表的主键
	 */
	private Integer bindingAccountId;

	public Integer getApplyId() {
		return applyId;
	}

	public void setApplyId(Integer applyId) {
		this.applyId = applyId;
	}

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Long getAmount() {
		return amount;
	}

	public void setAmount(Long amount) {
		this.amount = amount;
	}

	public Long getCurrentBalance() {
		return currentBalance;
	}

	public void setCurrentBalance(Long currentBalance) {
		this.currentBalance = currentBalance;
	}

	public Integer getApplyUserId() {
		return applyUserId;
	}

	public void setApplyUserId(Integer applyUserId) {
		this.applyUserId = applyUserId;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public Integer getAuditUserId() {
		return auditUserId;
	}

	public void setAuditUserId(Integer auditUserId) {
		this.auditUserId = auditUserId;
	}

	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getAuditNote() {
		return auditNote;
	}

	public void setAuditNote(String auditNote) {
		this.auditNote = auditNote;
	}

	public Date getTransferTime() {
		return transferTime;
	}

	public void setTransferTime(Date transferTime) {
		this.transferTime = transferTime;
	}

	public Integer getBindingAccountId() {
		return bindingAccountId;
	}

	public void setBindingAccountId(Integer bindingAccountId) {
		this.bindingAccountId = bindingAccountId;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}
	
	public Long getCashSubsidyAmount() {
		return cashSubsidyAmount;
	}

	public void setCashSubsidyAmount(Long cashSubsidyAmount) {
		this.cashSubsidyAmount = cashSubsidyAmount;
	}

	public Long getPriceSubsidyAmount() {
		return priceSubsidyAmount;
	}

	public void setPriceSubsidyAmount(Long priceSubsidyAmount) {
		this.priceSubsidyAmount = priceSubsidyAmount;
	}

	public Long getCouponSubsidyAmount() {
		return couponSubsidyAmount;
	}

	public void setCouponSubsidyAmount(Long couponSubsidyAmount) {
		this.couponSubsidyAmount = couponSubsidyAmount;
	}

	public Long getHaveWithdraw() {
		return haveWithdraw;
	}

	public void setHaveWithdraw(Long haveWithdraw) {
		this.haveWithdraw = haveWithdraw;
	}
}