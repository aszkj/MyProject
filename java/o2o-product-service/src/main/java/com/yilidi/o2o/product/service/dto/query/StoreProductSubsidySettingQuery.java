package com.yilidi.o2o.product.service.dto.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;
/**
 * 
 * @Description:TODO(补贴商品设置查询封装类 ) 
 * @author: llp
 * @date:	2015年11月10日 上午11:07:21 
 *
 */
public class StoreProductSubsidySettingQuery extends BaseQuery {
	/** 
	 * @Fields serialVersionUID : TODO(serialVersionUID) 
	 */ 
	private static final long serialVersionUID = -1214891362294119123L;

	/**
	 * 商品ID，对应产品域P_SALEPRODUCT 表的ID
	 */
	private Integer saleProductId;
	
	/**
	 * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
	 */
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
	 * 商品条形码
	 */
	private String barCode;
	
	/**
	 * 商品名称
	 */
	private String saleProductName;
	
	/**
	 * 门店ID的list
	 */
	private List<Integer> storeIdList;
	
	/**
	 * 商品一级分类
	 */
	private String parentCode;
	
	/**
	 * 商品分类
	 */
	private String productClassCode;
	
	/**
	 * 是否有效商品标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTENABLEDFLAG)。该字段对用户操作不可见，当该商品引用的商品被设置为禁用时，该字段需要更新为“
	 * SALEPRODUCTENABLEDFLAG_OFF” 无效状态。当商品设置为启用状态是，该字段更新为"SALEPRODUCTENABLEDFLAG_ON"有效状态。默认为"SALEPRODUCTENABLEDFLAG_ON"
	 */
	private String enabledFlag;
	
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

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public List<Integer> getStoreIdList() {
		return storeIdList;
	}

	public void setStoreIdList(List<Integer> storeIdList) {
		this.storeIdList = storeIdList;
	}

	public String getSaleProductName() {
		return saleProductName;
	}

	public void setSaleProductName(String saleProductName) {
		this.saleProductName = saleProductName;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getProductClassCode() {
		return productClassCode;
	}

	public void setProductClassCode(String productClassCode) {
		this.productClassCode = productClassCode;
	}

	public String getEnabledFlag() {
		return enabledFlag;
	}

	public void setEnabledFlag(String enabledFlag) {
		this.enabledFlag = enabledFlag;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

}
