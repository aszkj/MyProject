package com.yilidi.o2o.product.model;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品实体类，关联产品域表YiLiDiProductCenter.P_PRODUCT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class Product extends BaseModel {
	private static final long serialVersionUID = 5147037786145522007L;
	private static final String DEFAULT_STATUSCODE = "PRODUCTSTATUS_ON";
//	private static final String DEFAULT_BRANDCODE = "XX";
	public Product() {
		this.statusCode = DEFAULT_STATUSCODE;
//		this.brandCode = DEFAULT_BRANDCODE;
	}

	/**
	 * 产品ID
	 */
	private Integer id;
	/**
	 * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
	 */
	private String productClassCode;
	/**
	 * 产品编码，关联产品域品牌表P_PRODUCT_BRAND的BRANDCODE字段
	 */
	private String brandCode;
	/**
	 * 产品名称
	 */
	private String productName;
	/**
	 * 产品条形码，产品的唯一标识
	 */
	private String barCode;
	
	/**
	 * 产品状态, 标识该产品是否有效，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSTATUS)
	 */
	private String statusCode;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;

	/**
	 * 将产品价格实体作为属性注入
	 */
	private ProductPrice productPrice;
	/**
	 * 将产品图片实体作为属性注入 *可能有多个图片
	 */
	private List<ProductImage> productImages;
	/**
	 * 将产品描述信息实体作为属性注入
	 */
	private ProductProfile productProfile;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProductClassCode() {
		return productClassCode;
	}

	public void setProductClassCode(String productClassCode) {
		this.productClassCode = productClassCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
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

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
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

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public ProductPrice getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(ProductPrice productPrice) {
		this.productPrice = productPrice;
	}

	public List<ProductImage> getProductImages() {
		return productImages;
	}

	public void setProductImages(List<ProductImage> productImages) {
		this.productImages = productImages;
	}

	public ProductProfile getProductProfile() {
		return productProfile;
	}

	public void setProductProfile(ProductProfile productProfile) {
		this.productProfile = productProfile;
	}
}