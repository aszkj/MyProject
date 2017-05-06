/**
 * 文件名称：ProductInventoryResult.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.model.result;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：库存查询映射结构 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductInventoryResult extends BaseModel {
	private static final long serialVersionUID = 5385062843602259935L;

	/**
	 * 库存id
	 */
	private Integer id;
	/**
	 * 商品类别
	 */
	private String productClass;
	/**
	 * 品牌
	 */
	private String brandCode;
	/**
	 * 型号
	 */
	private String modelCode;
	/**
	 * 颜色
	 */
	private String colorCode;
	/**
	 * 容量
	 */
	private String romCode;
	/**
	 * 上下架状态
	 */
	private String saleStatus;
	/**
	 * 供应商ID
	 */
	private Integer providerId;
	/**
	 * 库存量
	 */
	private Integer remainCount;
	/**
	 * 已订购数量
	 */
	private Integer orderedCount;
	/**
	 * 待发货数量
	 */
	private Integer standByCount;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public String getModelCode() {
		return modelCode;
	}

	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}

	public String getColorCode() {
		return colorCode;
	}

	public void setColorCode(String colorCode) {
		this.colorCode = colorCode;
	}

	public String getRomCode() {
		return romCode;
	}

	public void setRomCode(String romCode) {
		this.romCode = romCode;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public Integer getProviderId() {
		return providerId;
	}

	public void setProviderId(Integer providerId) {
		this.providerId = providerId;
	}

	public Integer getRemainCount() {
		return remainCount;
	}

	public void setRemainCount(Integer remainCount) {
		this.remainCount = remainCount;
	}

	public Integer getOrderedCount() {
		return orderedCount;
	}

	public void setOrderedCount(Integer orderedCount) {
		this.orderedCount = orderedCount;
	}

	public Integer getStandByCount() {
		return standByCount;
	}

	public void setStandByCount(Integer standByCount) {
		this.standByCount = standByCount;
	}

}
