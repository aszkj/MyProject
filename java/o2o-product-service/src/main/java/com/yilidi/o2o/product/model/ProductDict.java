package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品地点实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_DICT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductDict extends BaseModel {

	private static final long serialVersionUID = 1821118578920866486L;

	/**
	 * 字典ID， 自增主键
	 */
	private Integer dictId;

	/**
	 * 产品类别编码，关联产品域P_PRODUCT_CLASS表的PRODUCTCLASSCODE字段，标识该字典定义属于那个产品类别
	 */
	private String productClassCode;

	/**
	 * 产品字典名称
	 */
	private String dictName;
	/**
	 * 字典编码
	 */
	private String dictCode;
	/**
	 * 产品字典类型，关联产品域P_PRODUCT_BASIC_PROPS表的PROPSCODE字段，标识该字典定义属于那个产品基础属性
	 */
	private String dictType;
	/**
	 * 字典描述
	 */
	private String dictDesc;
	/**
	 * 排序
	 */
	private Integer sort;
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

	public Integer getDictId() {
		return dictId;
	}

	public void setDictId(Integer dictId) {
		this.dictId = dictId;
	}

	public String getProductClassCode() {
		return productClassCode;
	}

	public void setProductClassCode(String productClassCode) {
		this.productClassCode = productClassCode;
	}

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public String getDictCode() {
		return dictCode;
	}

	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}

	public String getDictType() {
		return dictType;
	}

	public void setDictType(String dictType) {
		this.dictType = dictType;
	}

	public String getDictDesc() {
		return dictDesc;
	}

	public void setDictDesc(String dictDesc) {
		this.dictDesc = dictDesc;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
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