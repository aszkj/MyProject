package com.yilidi.o2o.product.model.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：产品品牌实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_BRAND <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductBrandQuery extends BaseQuery {
	private static final long serialVersionUID = -6565713514280836459L;
	/**
	 * 品牌ID，自增主键
	 */
	private Integer id;
	/**
	 * 品牌名称
	 */
	private String brandName;
	/**
	 * 品牌描述
	 */
	private String brandDesc;

	/**
	 * 品牌编码
	 */
	private String brandCode;
	/**
	 * 是否热门 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=HOTSALEFLAG)
	 */
	private String type;

	/**
	 * 状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTBRANDSTATUS)
	 */
	private String statusCode;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 品牌顺序
	 */
	private Integer displayOrder;
	/**
	 * 品牌code集合
	 */
	private List<String> brandCodesList;

	public List<String> getBrandCodesList() {
		return brandCodesList;
	}

	public void setBrandCodesList(List<String> brandCodesList) {
		this.brandCodesList = brandCodesList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getBrandDesc() {
		return brandDesc;
	}

	public void setBrandDesc(String brandDesc) {
		this.brandDesc = brandDesc;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
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

}