/**
 * 文件名称：StoreQuery.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：用户查询条件封装类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StoreQuery extends BaseQuery {

	private static final long serialVersionUID = 3063107551753400367L;

	/**
	 * 店铺id
	 */
	private Integer storeId;
	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 店铺名称
	 */
	private String storeName;
	/**
	 * 店主名称（主帐号用户名）
	 */
	private String storeMaster;
	/**
	 * 店铺状态
	 */
	private String storeStatus;

	/**
	 * 客户名称
	 */
	private String customerName;

	/**
	 * 是否享受保证金带来的增值服务标识
	 */
	private String enjoyDepositBenefitsFlag;

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

	public String getStoreMaster() {
		return storeMaster;
	}

	public void setStoreMaster(String storeMaster) {
		this.storeMaster = storeMaster;
	}

	public String getStoreStatus() {
		return storeStatus;
	}

	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getEnjoyDepositBenefitsFlag() {
		return enjoyDepositBenefitsFlag;
	}

	public void setEnjoyDepositBenefitsFlag(String enjoyDepositBenefitsFlag) {
		this.enjoyDepositBenefitsFlag = enjoyDepositBenefitsFlag;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

}
