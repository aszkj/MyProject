package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(门店账本交易(收入和支付)明细的各种金额统计管理模块) 
 * @author:	llp
 * @date:	2015年11月10日 上午9:54:10 
 *
 */
public class AccountDetailCountInfo extends BaseModel {
	/** 
	 * @Fields serialVersionUID : TODO(序列号) 
	 */ 
	private static final long serialVersionUID = -1256542799920122489L;

	/**
	 * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
	 */
	private Integer storeId;
	
	/**
	 * 客户名称(门店名称)
	 */
	private String storeName;
	
	/**
	 * 门店编码
	 */
	private String storeCode;
	
	/**
	 * 统计每个没电的所有订单现金补贴金额
	 */
	private Long cashSubsidy;
	
	/**
     * 统计每个门店的所有订单商品差价补贴总金额
     */
    private Long priceSubsidy;
    
    /**
	 * 统计每个门店的所有订单优惠券/代金券补贴总金额
	 */
	private Long couponSubsidy;
	
	/**
	 * 统计每个门店的所有订单物流补贴总金额
	 */
	private Long logisticsSubsidy;
		
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
	
	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Long getCouponSubsidy() {
		return couponSubsidy;
	}

	public void setCouponSubsidy(Long couponSubsidy) {
		this.couponSubsidy = couponSubsidy;
	}

	public Long getLogisticsSubsidy() {
		return logisticsSubsidy;
	}

	public void setLogisticsSubsidy(Long logisticsSubsidy) {
		this.logisticsSubsidy = logisticsSubsidy;
	}

	public Long getPriceSubsidy() {
		return priceSubsidy;
	}

	public void setPriceSubsidy(Long priceSubsidy) {
		this.priceSubsidy = priceSubsidy;
	}

	public Long getCashSubsidy() {
		return cashSubsidy;
	}

	public void setCashSubsidy(Long cashSubsidy) {
		this.cashSubsidy = cashSubsidy;
	}
}
