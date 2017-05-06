/**
 * 文件名称：CustomerBalanceQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：客户账户余额查询条件封装类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CustomerBalanceQuery extends BaseQuery {

	private static final long serialVersionUID = 3063107551753400367L;
	
	private Integer storeId;
	/**
	 * 客户类别：买家，卖家,运营商等
	 */
	private String customerType;
	
	/**
	 * 客户名称：零售商名称，供应商名称，运营商（机构）名称
	 */
	private String storeName;
	
	/**
	 * 门店编码
	 */
	private String storeCode;
	
	/**
	 * 帐户类型：标识该帐户的类型，关联用户域U_ACCOUNT表ACCOUNTTYPECODE字段
	 * 买家：现金账本（欧币）
	 * 卖家：现金账本（订单提现），商品差价补贴账本，优惠补贴账本，物流补贴账本
	 */
	private String accountTypeCode;
	
	/**
	 * 用户名
	 */
	private String userName;

	/**
	 * 用户手机号码
	 */
	private String telPhone;
	
	
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

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}
}
