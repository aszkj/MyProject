package com.yilidi.o2o.product.model;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：价格差异化实体类，映射产品域表YiLiDiProductCenter.P_PRICE_OTHERNESS <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PriceOtherness extends BaseModel {
	private static final long serialVersionUID = -7164431099116717869L;
	/**
	 * 价格差异化ID，自增主键
	 */
	private Integer id;
	/**
	 * 运营商ID, 关联用户域客户表U_CUSTOMER中的CUMSTOMERID字段（CUSTOMERTYPE=''CUSTOMERTYPE_OPERATOR''）
	 */
	private Integer operatorId;
	/**
	 * 平台产品库产品ID， 关联产品域供应商产品表P_SALE_PRODUCT中的SALEPRODUCTID字段
	 */
	private Integer productId;
	/**
	 * 促销价变化量， 单位 厘
	 */
	private Long promotionalPriceDelta;
	/**
	 * 零售价变化量， 单位 厘
	 */
	private Long retailPriceDelta;

	/**
	 * 产品类别，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
	 */
	private String productClass;

	/**
	 * 产品品牌，关联产品域品牌表P_PRODUCT_BRAND的BRANDCODE字段
	 */
	private String brandCode;

	/**
	 * 产品名称
	 */
	private String productName;

	/**
	 * 状态, 标识该产品是否有效，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRICEOTHERNESSSTATUS)
	 */
	private String status;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 备注
	 */
	private String note;

	/**
	 * 价格差异化的地区设置
	 */
	List<PriceOthernessArea> areas;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Long getPromotionalPriceDelta() {
		return promotionalPriceDelta;
	}

	public void setPromotionalPriceDelta(Long promotionalPriceDelta) {
		this.promotionalPriceDelta = promotionalPriceDelta;
	}

	public Long getRetailPriceDelta() {
		return retailPriceDelta;
	}

	public void setRetailPriceDelta(Long retailPriceDelta) {
		this.retailPriceDelta = retailPriceDelta;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public List<PriceOthernessArea> getAreas() {
		return areas;
	}

	public void setAreas(List<PriceOthernessArea> areas) {
		this.areas = areas;
	}

	public String getProductClass() {
		return productClass;
	}

	public void setProductClass(String productClass) {
		this.productClass = productClass;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
}