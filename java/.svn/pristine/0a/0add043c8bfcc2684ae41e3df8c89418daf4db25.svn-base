package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * @Description:TODO(将用户（买家和门店）各账本的余额统计相关信息进行组合封装，供Mybatis使用) 
 * @author:	llp
 * @date:	2015年11月28日 上午10:44:02 
 *
 */
public class AccountRelatedInfo extends BaseModel {

	private static final long serialVersionUID = 2768830166091073688L;

	/**
	 * 账户ID，主键
	 */
	private Integer accountId;

	/**
	 * 该帐户所属客户的ID，关联表U_CUSTOMER的customerId字段
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
	 * 账本金额，单位 厘
	 */
	private Long currentBalance;
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
	 * 客户类别
	 */
	private String customerType;
	/**
	 * 用户名
	 */
	private String userName;
	
	/**
	 * 帐户类型：标识该帐户的类型，关联用户域U_ACCOUNT表ACCOUNTTYPECODE字段
	 * 买家：现金账本（欧币）
	 * 卖家：现金账本（订单提现），商品差价补贴账本，优惠补贴账本，物流补贴账本
	 */
	private String accountTypeCode;
	
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

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}

	public Long getCurrentWithdrawBalance() {
		return currentWithdrawBalance;
	}

	public void setCurrentWithdrawBalance(Long currentWithdrawBalance) {
		this.currentWithdrawBalance = currentWithdrawBalance;
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

	public Long getTotalAccount() {
		return totalAccount;
	}

	public void setTotalAccount(Long totalAccount) {
		this.totalAccount = totalAccount;
	}

	public Long getCashAccount() {
		return cashAccount;
	}

	public void setCashAccount(Long cashAccount) {
		this.cashAccount = cashAccount;
	}

	public Long getProdcutAccount() {
		return prodcutAccount;
	}

	public void setProdcutAccount(Long prodcutAccount) {
		this.prodcutAccount = prodcutAccount;
	}

	public Long getCouponAccount() {
		return couponAccount;
	}

	public void setCouponAccount(Long couponAccount) {
		this.couponAccount = couponAccount;
	}

	public Long getLogisticsAccount() {
		return logisticsAccount;
	}

	public void setLogisticsAccount(Long logisticsAccount) {
		this.logisticsAccount = logisticsAccount;
	}

	public Long getCurrentBalance() {
		return currentBalance;
	}

	public void setCurrentBalance(Long currentBalance) {
		this.currentBalance = currentBalance;
	}

}