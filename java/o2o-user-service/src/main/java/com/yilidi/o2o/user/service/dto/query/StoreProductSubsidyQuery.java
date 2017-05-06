package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;
/**
 * 
 * @Description:TODO(商品差价补贴明细查询封装类 ) 
 * @author: llp
 * @date:	2015年11月11日 上午11:07:21 
 *
 */
public class StoreProductSubsidyQuery extends BaseQuery {
	/** 
	 * @Fields serialVersionUID : TODO(serialVersionUID) 
	 */ 
	private static final long serialVersionUID = -1214891362294119123L;

	private Integer storeId;
	
	/**
	 * 客户名称：零售商名称，供应商名称，运营商（机构）名称
	 */
	private String storeName;
	
	/**
	 * 门店编码
	 */
	private String storeCode;
	
	 /**
     * 订单编号，关联订单域T_SALE_ORDER表的SALEORDERNO
     */
    private String saleOrderNo;
    
    /**
     * 商品名称
     */
    private String productName;
    
	/**
	 * 补贴开始时间
	 */
	private String startCreateTime;
	
	/**
	 * 补贴结束时间
	 */
	private String endCreateTime;
	
	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
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

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}
}
