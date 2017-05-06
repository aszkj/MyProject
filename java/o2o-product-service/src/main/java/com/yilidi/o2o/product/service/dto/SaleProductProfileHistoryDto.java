/**
 * 文件名称：SaleProductProfileHistoryDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品历史描述模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductProfileHistoryDto extends BaseDto {
	private static final long serialVersionUID = 2977002291281886100L;
	/**
	 * ID, 自增主键
	 */
	private Integer id;
	/**
	 * 商品描述ID
	 */
	private Integer saleProductProfileId;
	/**
	 * 商品ID
	 */
	private Integer saleProductId;
	/**
	 * 渠道编码
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
	 * 商品上下架状态
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
	 * 操作用户id
	 */
	private Integer operateUserId;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作类型
	 */
	private String operateType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSaleProductProfileId() {
		return saleProductProfileId;
	}

	public void setSaleProductProfileId(Integer saleProductProfileId) {
		this.saleProductProfileId = saleProductProfileId;
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

	public Integer getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(Integer operateUserId) {
		this.operateUserId = operateUserId;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

}
