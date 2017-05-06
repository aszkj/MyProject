package com.yilidi.o2o.product.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品基本属性实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_BASIC_PROPS <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductBasicProps extends BaseModel {
	private static final long serialVersionUID = -1927925084135523154L;
	/**
	 * 属性ID，自增主键
	 */
	private Integer id;
	/**
	 * 产品类别编码, 关联产品域P_PRODUCT_CLASS表的PRODUCTCLASSCODE字段，标识该属性是属于那个类型的产品
	 */
	private String productClassCode;
	/**
	 * 属性名称
	 */
	private String propsName;
	/**
	 * 属性编码
	 */
	private String propsCode;
	/**
	 * 属性级别，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTPROPSLEVEL)
	 */
	private String propsLevel;
	/**
	 * 父级属性ID，关联本表的属性ID字段
	 */
	private Integer parentId;
	/**
	 * 属性描述
	 */
	private String propsDesc;
	/**
	 * 主显示标志, 用于标识该字段是否需要在添加产品时，将该字段显示在基本信息页面中，同时标识在前台页面中显示，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTPROPSSHOWFLAG)
	 */
	private String showFlag;

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

	public String getPropsName() {
		return propsName;
	}

	public void setPropsName(String propsName) {
		this.propsName = propsName;
	}

	public String getPropsCode() {
		return propsCode;
	}

	public void setPropsCode(String propsCode) {
		this.propsCode = propsCode;
	}

	public String getPropsLevel() {
		return propsLevel;
	}

	public void setPropsLevel(String propsLevel) {
		this.propsLevel = propsLevel;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getPropsDesc() {
		return propsDesc;
	}

	public void setPropsDesc(String propsDesc) {
		this.propsDesc = propsDesc;
	}

	public String getShowFlag() {
		return showFlag;
	}

	public void setShowFlag(String showFlag) {
		this.showFlag = showFlag;
	}
}