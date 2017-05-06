package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 楼层信息DTO
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午2:18:46
 */
public class FloorDto extends BaseDto {

    private static final long serialVersionUID = -5205323864799407073L;

    /**
     * 楼层ID，自增主键
     */
    private Integer id;

    /**
     * 楼层名称
     */
    private String floorName;

    /**
     * 楼层icon图片URL
     */
    private String floorImageUrl;

    /**
     * 楼层icon图片全URL
     */
    private String floorImageFullUrl;

    /**
     * 楼层icon图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlag;

    /**
     * 被删除的楼层icon图片URL
     */
    private String delImageUrl;

    /**
     * 楼层排序
     */
    private Integer sort;

    /**
     * 楼层状态编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORSTATUS)
     */
    private String statusCode;

    /**
     * 楼层状态编码名称
     */
    private String statusCodeName;

    /**
     * 楼层跳转链接类型编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORLINKTYPE)
     */
    private String linkType;

    /**
     * 关键链接数据
     */
    private String linkData;

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
     * 产品分类编码
     */
    private String productClassCode;

    /**
     * 广告类型编码
     */
    private String advertisementTypeCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFloorName() {
        return floorName;
    }

    public void setFloorName(String floorName) {
        this.floorName = floorName;
    }

    public String getFloorImageUrl() {
        return floorImageUrl;
    }

    public void setFloorImageUrl(String floorImageUrl) {
        this.floorImageUrl = floorImageUrl;
    }

    public String getFloorImageFullUrl() {
        return floorImageFullUrl;
    }

    public void setFloorImageFullUrl(String floorImageFullUrl) {
        this.floorImageFullUrl = floorImageFullUrl;
    }

    public String getImageFlag() {
        return imageFlag;
    }

    public void setImageFlag(String imageFlag) {
        this.imageFlag = imageFlag;
    }

    public String getDelImageUrl() {
        return delImageUrl;
    }

    public void setDelImageUrl(String delImageUrl) {
        this.delImageUrl = delImageUrl;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getLinkType() {
        return linkType;
    }

    public void setLinkType(String linkType) {
        this.linkType = linkType;
    }

    public String getLinkData() {
        return linkData;
    }

    public void setLinkData(String linkData) {
        this.linkData = linkData;
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

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getAdvertisementTypeCode() {
        return advertisementTypeCode;
    }

    public void setAdvertisementTypeCode(String advertisementTypeCode) {
        this.advertisementTypeCode = advertisementTypeCode;
    }

}