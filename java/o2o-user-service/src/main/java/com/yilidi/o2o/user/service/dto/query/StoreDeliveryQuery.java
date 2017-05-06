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
 * 
 * 店铺接单员查询封装类
 * 
 * @author: heyong
 * @date: 2015年12月10日 下午1:55:36
 * 
 */
public class StoreDeliveryQuery extends BaseQuery {

	private static final long serialVersionUID = 7563008667930430936L;

	/**
	 * 店铺id
	 */
	private Integer storeId;

	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 门店名称
	 */
	private String storeName;
	/**
	 * 接单员登录账号
	 */
	private String userName;

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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
}
