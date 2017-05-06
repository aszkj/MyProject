package com.yilidi.o2o.user.proxy.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：门店用户代理服务使用DTO定义 <br/>
 * 作者：llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StoreProxyDto extends BaseDto {
	private static final long serialVersionUID = -4917034038990006306L;

	/**
	 * 门店ID
	 */
	private Integer id;

	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 门店名称
	 */
	private String storeName;
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
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
}
