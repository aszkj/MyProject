/**
 * 文件名称：AccountDto.java
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
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountDto extends BaseDto {
	private static final long serialVersionUID = -2184893739375023003L;

	/**
	 * 账户ID，主键
	 */
	private Integer accountId;
	/**
	 * 该帐户所属客户的ID，关联表U_CUSTOMER的customerid字段
	 */
	private Integer customerId;
	/**
	 * 门店编码
	 */
	private String storeCode;
	
	/**
	 * 门店名称
	 */
	private String storeName;
	/**
	 * 帐户类型编码，：现金账本等， 关联用户域U_ACCOUNT_TYPE_INFO的ACCOUNTTYPECODE字段，标识该账户的类型
	 */
	private String accountTypeCode;
	/**
	 * 账本余额，单位 厘
	 */
	private Long currentBalance;
	/**
	 * 当前已使用的账本总金额(买家：欧币)
	 * 卖家：暂未考虑，后续需要可扩展
	 */
	private Long usedAccountTotalAmount;
	/**
	 * 冻结金额
	 */
	private Long freezeAmount;
	/**
	 * 每个用户账本金额的总和统计,单位厘
	 * 买家:现金账本（欧币）
	 * 卖家：现金账本+优惠券补贴+商品差价补贴+物流补贴
	 */
	private Long totalAccount;
	/**
     * 门店当前可提现总金额=门店提现金额 - 提现中余额(申请了提现，但未提现成功(待审核，审核通过),审核不通过的，即提现申请作废)
	 * 但提现成功，则扣除门店现金账本金额
     */
    private Long currentWithdrawBalance;
    /**
     * 用户现金账本金额，单位厘
     */
    private Long cashAccount;
    /**
     * 用户商品补贴账本金额，单位厘
     */
    private Long prodcutAccount;
    /**
     * 优惠券补贴账本金额，单位厘
     */
    private Long couponAccount;
    /**
     * 物流补贴账本金额，单位厘
     */
    private Long logisticsAccount;
    /**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建人
	 */
	private Integer createUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 修改人
	 */
	private Integer modifyUserId;

	/**
	 * 客户类别
	 */
	private String customerType;

	/**
	 * 用户名
	 */
	private String userName;

	/**
	 * 用户手机号
	 */
	private String telPhone;

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}
	
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTelPhone() {
		return telPhone;
	}

	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	
	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	
	public Long getLogisticsAccount() {
		return logisticsAccount;
	}

	public void setLogisticsAccount(Long logisticsAccount) {
		this.logisticsAccount = logisticsAccount;
	}

	public Long getCouponAccount() {
		return couponAccount;
	}

	public void setCouponAccount(Long couponAccount) {
		this.couponAccount = couponAccount;
	}

	public Long getProdcutAccount() {
		return prodcutAccount;
	}

	public void setProdcutAccount(Long prodcutAccount) {
		this.prodcutAccount = prodcutAccount;
	}

	public Long getCashAccount() {
		return cashAccount;
	}

	public void setCashAccount(Long cashAccount) {
		this.cashAccount = cashAccount;
	}

	public Long getCurrentWithdrawBalance() {
		return currentWithdrawBalance;
	}

	public void setCurrentWithdrawBalance(Long currentWithdrawBalance) {
		this.currentWithdrawBalance = currentWithdrawBalance;
	}

	public Long getTotalAccount() {
		return totalAccount;
	}

	public void setTotalAccount(Long totalAccount) {
		this.totalAccount = totalAccount;
	}

	public Long getCurrentBalance() {
		return currentBalance;
	}

	public void setCurrentBalance(Long currentBalance) {
		this.currentBalance = currentBalance;
	}

	public Long getFreezeAmount() {
		return freezeAmount;
	}

	public void setFreezeAmount(Long freezeAmount) {
		this.freezeAmount = freezeAmount;
	}

	public Long getUsedAccountTotalAmount() {
		return usedAccountTotalAmount;
	}

	public void setUsedAccountTotalAmount(Long usedAccountTotalAmount) {
		this.usedAccountTotalAmount = usedAccountTotalAmount;
	}

}
