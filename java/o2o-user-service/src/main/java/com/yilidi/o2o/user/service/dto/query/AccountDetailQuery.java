/**
 * 文件名称：AccountDetailQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：账户明细查询条件封装对象 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountDetailQuery extends BaseQuery {

	private static final long serialVersionUID = -1218645834967289425L;
	
	/**
	 * 交易流水号
	 */
	private String serialNo;

	/**
	 * 用户ID
	 */
	private Integer userId;

	/**
	 * 帐户类型：标识该帐户的类型，关联用户域U_ACCOUNT表ACCOUNTTYPECODE字段
	 * 买家：现金账本（欧币）
	 * 卖家：现金账本（订单提现），商品差价补贴账本，优惠补贴账本，物流补贴账本
	 */
	private String accountTypeCode;

	/**
	 * 明细类别：ACCOUNTDETAILTYPE_IN: 收入, ACCOUNTDETAILTYPE_OUT: 支出
	 */
	private String detailType;

	/**
	 * 查询的消费开始时间
	 */
	private String startCreateTime;

	/**
	 * 查询的消费结束时间
	 */
	private String endCreateTime;
	/**
	 * 帐户金额变化类型：ACCOUNTCHANGETYPE_CHARGE: 充值、ACCOUNTCHANGETYPE_WITHDRAW: 提款、ACCOUNTCHANGETYPE_PAY:
	 * 付款、ACCOUNTCHANGETYPE_REFUND: 退款.... 在系统字典中定义
	 */
	private String changeType;

	/**
	 * 客户类别
	 */
	private String customerType;

	/**
	 * 用户名
	 */
	private String userName;

	/**
	 * 支付平台：支付宝和微信
	 */
	private String payPlatform;
	
	/**
	 * 支付状态：支付成功和待支付
	 */
	private String payStatus;
	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 门店名称
	 */
	private String storeName;
	
	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}

	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
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
	
	public String getStartCreateTime() {
		return startCreateTime;
	}

	public void setStartCreateTime(String startCreateTime) {
		this.startCreateTime = startCreateTime;
	}

	public String getEndCreateTime() {
		return endCreateTime;
	}

	public void setEndCreateTime(String endCreateTime) {
		this.endCreateTime = endCreateTime;
	}
	
	public String getPayPlatform() {
		return payPlatform;
	}

	public void setPayPlatform(String payPlatform) {
		this.payPlatform = payPlatform;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
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
}
