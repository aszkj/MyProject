/**
 * 文件名称：SaleProductImageHistoryDto.java
 * 
 * 描述：商品图片模型Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品图片模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductImageHistoryDto extends BaseDto {
	private static final long serialVersionUID = 3728154435956785308L;
	/**
	 * 记录ID， 主键自增
	 */
	private Integer id;
	/**
	 * 店铺商品图片ID
	 */
	private Integer saleProductImageId;
	/**
	 * 店铺商品ID
	 */
	private Integer saleProductId;
	/**
	 * 渠道编码
	 */
	private String channelCode;
	/**
	 * 主图标志
	 */
	private String masterFlag;
	/**
	 * 图片URL
	 */
	private String imageUrl;
	/**
	 * 图片顺序，图片显示顺序（编号小的先显示，如果编号相同，则id小的先显示）
	 */
	private Integer imageOrder;
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

	public Integer getSaleProductImageId() {
		return saleProductImageId;
	}

	public void setSaleProductImageId(Integer saleProductImageId) {
		this.saleProductImageId = saleProductImageId;
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

	public String getMasterFlag() {
		return masterFlag;
	}

	public void setMasterFlag(String masterFlag) {
		this.masterFlag = masterFlag;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public Integer getImageOrder() {
		return imageOrder;
	}

	public void setImageOrder(Integer imageOrder) {
		this.imageOrder = imageOrder;
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