package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 数据包产品图片信息实体类，关联产品域表YiLiDiProductCenter.P_PACKET_PRODUCT_IMAGE
 * 
 * @author: chenlian
 * @date: 2016年12月9日 下午6:42:24
 */
public class AuditProductImage extends BaseModel {

    private static final long serialVersionUID = -3277276147134748989L;

    private static final Integer DEFAULT_IMAGEORDER = 1;

    public AuditProductImage() {
        this.imageOrder = DEFAULT_IMAGEORDER;
    }

    /**
     * 图片ID， 主键自增
     */
    private Integer id;
    /**
     * 批次号，关联产品域数据包产品批次信息表P_PACKET_PRODUCT_BATCH_INFO的BATCHNO
     */
    private String batchNo;
    /**
     * 数据包产品ID，关联产品域数据包产品表P_PACKET_PRODUCT的ID
     */
    private Integer auditProductId;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 主图标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTIMAGEMASTERFLAG)
     */
    private String masterFlag;
    /**
     * 图片URL1
     */
    private String imageUrl1;
    /**
     * 图片URL2
     */
    private String imageUrl2;
    /**
     * 图片URL3
     */
    private String imageUrl3;
    /**
     * 图片顺序，图片显示顺序
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
     * 数据来源
     */
    private String dataResource;
    

    public String getDataResource() {
		return dataResource;
	}

	public void setDataResource(String dataResource) {
		this.dataResource = dataResource;
	}
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Integer getAuditProductId() {
        return auditProductId;
    }

    public void setAuditProductId(Integer auditProductId) {
        this.auditProductId = auditProductId;
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

    public String getImageUrl1() {
        return imageUrl1;
    }

    public void setImageUrl1(String imageUrl1) {
        this.imageUrl1 = imageUrl1;
    }

    public String getImageUrl2() {
        return imageUrl2;
    }

    public void setImageUrl2(String imageUrl2) {
        this.imageUrl2 = imageUrl2;
    }

    public String getImageUrl3() {
        return imageUrl3;
    }

    public void setImageUrl3(String imageUrl3) {
        this.imageUrl3 = imageUrl3;
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

}