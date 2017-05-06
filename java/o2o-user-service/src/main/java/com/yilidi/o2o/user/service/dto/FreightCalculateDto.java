/**
 * 文件名称：FreightCalculateDto.java
 * 
 * 描述：
 * 
 * 修改
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.user.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：运费计算使用DTO定义 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class FreightCalculateDto extends BaseDto {

	private static final long serialVersionUID = -4917034038990006306L;

	/**
	 * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
	 */
	private Integer storeId;

	/**
	 * 买家收货地址的省份编码
	 */
	private String provinceCode;

	/**
	 * 买家收货地址的地市编码
	 */
	private String cityCode;

	/**
	 * 买家收货地址的区县编码
	 */
	private String countyCode;

	/**
	 * 商品的总重量
	 */
	private Integer weight;

	/**
	 * 商品的总数量
	 */
	private Integer quantity;

	/**
	 * 商品的总价
	 */
	private Long totalPrice;

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
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

	public Integer getWeight() {
		return weight;
	}

	public void setWeight(Integer weight) {
		this.weight = weight;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Long getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Long totalPrice) {
		this.totalPrice = totalPrice;
	}

}
