package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(店铺商品补贴设置实体类DTO) 
 * @author:	llp
 * @date:	2015年11月10日 上午9:54:10 
 *
 */
public class StoreProductSubsidySettingDto extends BaseDto {
	/** 
	 * @Fields serialVersionUID : TODO(序列号) 
	 */ 
	private static final long serialVersionUID = -457927384526258755L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 店铺商品ID, 关联产品域P_SALE_PRODUCT表的ID
	 */
	private Integer saleProductId;
	
	/**
	 * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
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
	 * 商品条形码
	 */
	private String barCode;
	
	/**
	 * 商品名称
	 */
	private String saleProductName;
	
	/**
	 * 创建人
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/**
	 * 产品类别名称
	 */
	private String className;
	
	/**
	 * 产品类别父类名称
	 */
	private String parentName;
	
	/**
	 * 是否已经添加到补贴商品库状态：ADDSTATUS_YES 和 ADDSTATUS_NO
	 */
	private String addStatusCode;
		
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
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

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getSaleProductName() {
		return saleProductName;
	}

	public void setSaleProductName(String saleProductName) {
		this.saleProductName = saleProductName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getAddStatusCode() {
		return addStatusCode;
	}

	public void setAddStatusCode(String addStatusCode) {
		this.addStatusCode = addStatusCode;
	}

}
