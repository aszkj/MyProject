/**
 * 文件名称：WithdrawApplyDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：查看申请提现记录详细信息对象 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class WithdrawApplyDto extends BaseDto {
	private static final long serialVersionUID = -2184893739375023003L;

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
	 * 客户名称(门店名称)
	 */
	private String customerName;
	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 市编码，关联系统域下表S_AREADICT的AREACODE字段
	 */
	private String cityCode;
	/**
	 * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
	 */
	private String countyCode;
	/**
	 * 门店详细地址
	 */
	private String addressDetail;
	/**
	 * 门店联系人
	 */
	private String contactName;
	/**
	 * 联系电话
	 */
	private String telPhone;
	/**
	 * 申请提现金额
	 */
	private Long amount;
	/**
	 * 账户当前可提现余额
	 * 当前门店账本（现金+优惠补贴+商品补贴）可提现金额，单位：厘
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
	 * 状态编码名称
	 */
	private String statusName;
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
	/**
	 * 提现银行code
	 */
	private String bankCode;
	/**
	 * 所属支行
	 */
	private String subBankName;
	/**
	 * 提现银行账号
	 */
	private String bankCardNo;
	
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

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
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

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	public Long getHaveWithdraw() {
		return haveWithdraw;
	}

	public void setHaveWithdraw(Long haveWithdraw) {
		this.haveWithdraw = haveWithdraw;
	}

	public Integer getBindingAccountId() {
		return bindingAccountId;
	}

	public void setBindingAccountId(Integer bindingAccountId) {
		this.bindingAccountId = bindingAccountId;
	}

	public String getBankCode() {
		return bankCode;
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getSubBankName() {
		return subBankName;
	}

	public void setSubBankName(String subBankName) {
		this.subBankName = subBankName;
	}

	public String getBankCardNo() {
		return bankCardNo;
	}

	public void setBankCardNo(String bankCardNo) {
		this.bankCardNo = bankCardNo;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getTelPhone() {
		return telPhone;
	}

	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCountyCode() {
		return countyCode;
	}

	public void setCountyCode(String countyCode) {
		this.countyCode = countyCode;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
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

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

}
