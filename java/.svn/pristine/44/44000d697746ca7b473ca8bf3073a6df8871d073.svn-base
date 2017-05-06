package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：店铺商品详情实体类，映射商品域表YiLiDiProductCenter.P_SALE_PRODUCT_DESCRIPTION <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductProfile extends BaseModel {
	private static final long serialVersionUID = 5150262275243777519L;
	private static final String DEFAULT_SALESTATUS = "SALEPRODUCTSALESTATUS_INIT";
	
	public SaleProductProfile() {
		this.setSaleStatus(DEFAULT_SALESTATUS);
	}
	/**
	 * ID, 自增主键
	 */
	private Integer id;
	/**
	 * 商品ID， 关联产品域店铺商品信息表P_SALE_PRODUCT的ID字段',
	 */
	private Integer saleProductId;
	/**
	 * 渠道编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=CHANNELTYPE)'
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
	 * 商品上下架状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTSALESTATUS)
	 */
	private String saleStatus;
	/**
	 * 详情内容
	 */
	private String content;
	/**
	 * 商品来源
	 */
	private String saleProductSource;
	/**
	 * 商品规格
	 */
	private String saleProductSpec;
	/**
	 * 显示顺序
	 */
	private Integer displayOrder;
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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public String getSaleProductSource() {
		return saleProductSource;
	}

	public void setSaleProductSource(String saleProductSource) {
		this.saleProductSource = saleProductSource;
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