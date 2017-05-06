package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 商品销售统计Dto
 * 
 * @author: heyong
 * @date: 2015年11月30日 下午5:48:09
 * 
 */
public class SaleProductStatisticsInfoDto extends BaseDto {

	private static final long serialVersionUID = 4727643530671634669L;

	/**
	 * 门店名称
	 */
	private String storeName;

	/**
	 * 门店编码
	 */
	private String storeCode;

	/**
	 * 商品条形码
	 */
	private String barCode;

	/**
	 * 商品名称
	 */
	private String productName;

	/**
	 * 下单数量
	 */
	private Integer orderCount;

	/**
	 * 下单的日期 不包括时分秒
	 */
	private String orderTime;

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

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(Integer orderCount) {
		this.orderCount = orderCount;
	}

	public String getOrderTime() {
		return orderTime;
	}

	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
}
