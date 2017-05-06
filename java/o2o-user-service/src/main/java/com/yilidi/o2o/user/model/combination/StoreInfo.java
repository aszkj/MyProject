package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：将门店客户与门店相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StoreInfo extends BaseModel {

	private static final long serialVersionUID = 2768830166091073688L;

	/**
	 * 客户ID(门店ID)，自增主键
	 */
	private Integer id;

	/**
	 * 客户（门店）名称：零售商名称，供应商名称，运营商（机构）名称
	 */
	private String storeName;
	
	/**
	 * 门店编码
	 */
	private String storeCode;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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