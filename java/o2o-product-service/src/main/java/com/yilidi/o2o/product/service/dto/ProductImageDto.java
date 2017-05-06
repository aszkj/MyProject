/**
 * 文件名称：ProductImageDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：产品图片模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductImageDto extends BaseDto {
	private static final long serialVersionUID = -6664460624500631830L;
	private static final Integer DEFAULT_IMAGEORDER = 1;
	
	public ProductImageDto() {
		this.imageOrder = DEFAULT_IMAGEORDER;
	}
	/**
	 * 图片ID， 关联产品域产品基础信息表P_PRODUCT_IMAGE的ID',
	 */
	private Integer id;
	/**
	 * 产品ID， 关联产品域产品基础信息表P_PRODUCT的ID',
	 */
	private Integer productId;
	/**
	 * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
	 */
	private String channelCode;
	/**
	 * 主图标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTIMAGEMASTERFLAG)
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
	 * APP产品图片增加标示
	 */
	private String appImageFlag;

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

	public String getAppImageFlag() {
		return appImageFlag;
	}

	public void setAppImageFlag(String appImageFlag) {
		this.appImageFlag = appImageFlag;
	}

}
