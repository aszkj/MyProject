package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品描述实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_DESCRIPTION <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductProfile extends BaseModel {
	private static final long serialVersionUID = 7514989157457239912L;
	private static final String DEFAULT_PRODUCTOWNER = "PRODUCTOWNER_OTHER";
	private static final String DEFAULT_HOTSALEFLAG = "HOTSALEFLAG_NO";
	private static final String DEFAULT_MAINTAINSTOREFLAG = "MAINTAINSTOREFLAG_NO";
	private static final String DEFAULT_SALESTATU = "PRODUCTSALESTATUS_INIT";


	public ProductProfile() {
		this.productOwner = DEFAULT_PRODUCTOWNER;
		this.hotSaleFlag = DEFAULT_HOTSALEFLAG;
		this.maintainStoreFlag = DEFAULT_MAINTAINSTOREFLAG;
		this.saleStatus = DEFAULT_SALESTATU;
	}
	/**
	 * ID, 自增主键
	 */
	private Integer id;
	/**
	 * 产品ID， 关联产品域产品基础信息表的PRODUCTID字段'
	 */
	private Integer productId;
	/**
	 * 渠道编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=CHANNELTYPE)
	 */
	private String channelCode;
	/**
	 * 卖点描述
	 */
	private String sellPoint;
	/**
	 * 产品归属
	 */
	private String productOwner;
	/**
	 * 是否热卖
	 */
	private String hotSaleFlag;
	/**
	 * 上架状态, 标识该产品是否上架，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
	 */
	private String saleStatus;
	/**
	 * 产品规格
	 */
	private String productSpec;
	/**
	 * 显示顺序
	 */
	private Integer displayOrder;
	/**
	 * 详情内容
	 */
	private String content;
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
	 * 系统是否可维护库存,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=MAINTAINSTOREFLAG)
	 */
	private String maintainStoreFlag;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}

	public String getSellPoint() {
		return sellPoint;
	}

	public void setSellPoint(String sellPoint) {
		this.sellPoint = sellPoint;
	}

	public String getProductOwner() {
		return productOwner;
	}

	public void setProductOwner(String productOwner) {
		this.productOwner = productOwner;
	}

	public String getHotSaleFlag() {
		return hotSaleFlag;
	}

	public void setHotSaleFlag(String hotSaleFlag) {
		this.hotSaleFlag = hotSaleFlag;
	}

	public String getSaleStatus() {
		return saleStatus;
	}

	public void setSaleStatus(String saleStatus) {
		this.saleStatus = saleStatus;
	}

	public String getProductSpec() {
		return productSpec;
	}

	public void setProductSpec(String productSpec) {
		this.productSpec = productSpec;
	}

	public Integer getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(Integer displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public String getMaintainStoreFlag() {
		return maintainStoreFlag;
	}

	public void setMaintainStoreFlag(String maintainStoreFlag) {
		this.maintainStoreFlag = maintainStoreFlag;
	}
}