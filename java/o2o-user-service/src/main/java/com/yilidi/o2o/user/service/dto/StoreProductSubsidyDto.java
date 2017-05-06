package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(店铺商品差价补贴金额转可提现记录DTO) 
 * @author:	llp
 * @date:	2015年11月10日 上午9:54:10 
 *
 */
public class StoreProductSubsidyDto extends BaseDto {
	/** 
	 * @Fields serialVersionUID : TODO(序列号) 
	 */ 
	private static final long serialVersionUID = -6991840667981521282L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

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
     * 订单编号，关联订单域T_SALE_ORDER表的SALEORDERNO
     */
    private String saleOrderNo;
    
    /**
     * 店铺商品ID，关联产品域店铺商品表P_SALE_PRODUCT的ID字段
     */
    private Integer saleProductId;
    
    /**
     * 店铺商品名称，关联产品域店铺商品表P_SALE_PRODUCT的PRODUCTNAME字段
     */
    private String productName;
    
    /**
     * 店铺商品的零售价，单位厘
     */
    private Long retailPrice;
    
    /**
     * 平台的活动价，促销价，单位厘
     */
    private Long promotionalPrice;
    
	/**
	 * 商品差价补贴金额， 单位 厘
	 */
	private Long priceSubsidy;

	/**
	 * 商品数量
	 */
	private Integer productNum;
	
	/**
	 * 转可提现状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=TRANSWITHDRAWSTATUS)
	 */
	private String transWithdrawStatus;

	/**
	 * 创建人
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 修改人
	 */
	private Integer modifyUserId;

	/**
	 * 修改时间
	 */
	private Date modifyTime;
	
	/**
	 * 备注信息
	 */
	private String remark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getTransWithdrawStatus() {
		return transWithdrawStatus;
	}

	public void setTransWithdrawStatus(String transWithdrawStatus) {
		this.transWithdrawStatus = transWithdrawStatus;
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

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public Long getPriceSubsidy() {
		return priceSubsidy;
	}

	public void setPriceSubsidy(Long priceSubsidy) {
		this.priceSubsidy = priceSubsidy;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public Long getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(Long retailPrice) {
		this.retailPrice = retailPrice;
	}

	public Long getPromotionalPrice() {
		return promotionalPrice;
	}

	public void setPromotionalPrice(Long promotionalPrice) {
		this.promotionalPrice = promotionalPrice;
	}

	public Integer getProductNum() {
		return productNum;
	}

	public void setProductNum(Integer productNum) {
		this.productNum = productNum;
	}

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

}
