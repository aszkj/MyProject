/**
 * 文件名称：SaleProductTempQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：临时商品查询条件封装类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductTempQuery extends BaseQuery {
	private static final long serialVersionUID = 2495021810619489952L;
	/**
	 * 临时商品ID
	 */
	private Integer tempId;
	/**
	 * 店铺ID, 关联客户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
	 */
	private Integer storeId;
	/**
	 * 产品ID, 关联产品域P_PRODUCT表的PRODUCTID字段
	 */
	private Integer productId;
	/**
	 * 商品ID, 关联产品域P_SALE_PRODUCT表的SALEPRODUCTID字段
	 */
	private Integer saleProductId;
	/**
	 * 商品类别编码，关联商品域商品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
	 */
	private String productClassCode;
	/**
	 * 商品名称
	 */
	private String productName;
	/**
	 * 产品条形码，产品的唯一标识
	 */
	private String barCode;
	/**
	 * 审核状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTAUDITSTATUS)
	 */
	private String auditStatusCode;

	/**
	 * 商品查询促销价最大值，单位厘
	 */
	private Long promotionalMaxPrice;
	/**
	 * 商品查询促销价最小值，单位厘
	 */
	private Long promotionalMinPrice;
	/**
	 * 商品查询零售价最大范围值，单位厘
	 */
	private Long retailMaxPrice;
	/**
	 * 商品查询零售价最小范围值，单位厘
	 */
	private Long retailMinPrice;
	/**
	 * 是否热卖
	 */
	private String hotSaleFlag;
	/**
	 * 详情内容
	 */
	private String content;
	/**
	 * 商品规格
	 */
	private String saleProductSpec;
	/**
	 * 商品顺序
	 */
	private Integer displayOrder;
	/**
	 * 商品上下架状态
	 */
	private String saleStatus;
	/**
	 * 查询修改用户ID
	 */
	private Integer modifyUserId;
	/**
	 * 查询修改开始时间
	 */
	private Date startModifyTime;
	/**
	 * 查询修改结束时间
	 */
	private Date endModifyTime;
	/**
	 * 渠道编码
	 */
	private String channelCode;

	public Integer getTempId() {
		return tempId;
	}

	public void setTempId(Integer tempId) {
		this.tempId = tempId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public String getProductClassCode() {
		return productClassCode;
	}

	public void setProductClassCode(String productClassCode) {
		this.productClassCode = productClassCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public String getAuditStatusCode() {
		return auditStatusCode;
	}

	public void setAuditStatusCode(String auditStatusCode) {
		this.auditStatusCode = auditStatusCode;
	}

	public Long getPromotionalMaxPrice() {
		return promotionalMaxPrice;
	}

	public void setPromotionalMaxPrice(Long promotionalMaxPrice) {
		this.promotionalMaxPrice = promotionalMaxPrice;
	}

	public Long getPromotionalMinPrice() {
		return promotionalMinPrice;
	}

	public void setPromotionalMinPrice(Long promotionalMinPrice) {
		this.promotionalMinPrice = promotionalMinPrice;
	}

	public Long getRetailMaxPrice() {
		return retailMaxPrice;
	}

	public void setRetailMaxPrice(Long retailMaxPrice) {
		this.retailMaxPrice = retailMaxPrice;
	}

	public Long getRetailMinPrice() {
		return retailMinPrice;
	}

	public void setRetailMinPrice(Long retailMinPrice) {
		this.retailMinPrice = retailMinPrice;
	}

	public String getHotSaleFlag() {
		return hotSaleFlag;
	}

	public void setHotSaleFlag(String hotSaleFlag) {
		this.hotSaleFlag = hotSaleFlag;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSaleProductSpec() {
		return saleProductSpec;
	}

	public void setSaleProductSpec(String saleProductSpec) {
		this.saleProductSpec = saleProductSpec;
	}

	public Integer getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getStartModifyTime() {
		return startModifyTime;
	}

	public void setStartModifyTime(Date startModifyTime) {
		this.startModifyTime = startModifyTime;
	}

	public Date getEndModifyTime() {
		return endModifyTime;
	}

	public void setEndModifyTime(Date endModifyTime) {
		this.endModifyTime = endModifyTime;
	}

	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}

}
