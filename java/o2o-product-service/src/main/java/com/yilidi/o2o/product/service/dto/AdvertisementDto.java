package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：广告配置实体类，映射产品域表YiLiDiProductCenter.P_ADVERTISEMENT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AdvertisementDto extends BaseDto {
    private static final long serialVersionUID = 2269561720166649712L;
    /**
     * 广告ID, 自增主键
     */
    private Integer id;
    /**
     * 广告名称
     */
    private String advertisementName;
    /**
     * 广告类型编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=ADVERTISEMENTTYPE)
     */
    private String typeCode;
    /**
     * 广告类型编码名称
     */
    private String typeCodeName;
    /**
     * 图片URL
     */
    private String imageUrl;
    /**
     * 图片全URL
     */
    private String imageFullUrl;
    /**
     * 链接数据
     */
    private String linkData;
    /**
     * 开始时间
     */
    private Date startTime;
    /**
     * 开始时间(字符串)
     */
    private String strStartTime;
    /**
     * 链接类型
     */
    private String linkType;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 结束时间(字符串)
     */
    private String strEndTime;
    /**
     * 图片的点击此时
     */
    private Integer clickCount;
    /**
     * 状态编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=ADVERTISEMENTSTATUS)
     */
    private String statusCode;
    /**
     * 状态编码名称
     */
    private String statusCodeName;
    /**
     * 排序
     */
    private Integer sort;
    /**
     * 广告描述
     */
    private String advertisementDesc;
    /**
     * 创建用户Id
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
     * 广告图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlag;
    /**
     * 被删除的广告图片URL
     */
    private String delImageUrl;
    /**
     * 专题类型
     */
    private String themeType;
    /**
     * 活动类型
     */
    private String activityType;
    /**
     * 产品分类编码
     */
    private String productClassCode;
    /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 链接URL
     */
    private String linkUrl;
    /**
     * H5页面类型
     */
    private String h5PageType;

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setAdvertisementId(Integer id) {
        this.id = id;
    }

    public String getAdvertisementName() {
        return advertisementName;
    }

    public void setAdvertisementName(String advertisementName) {
        this.advertisementName = advertisementName;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getTypeCodeName() {
        return typeCodeName;
    }

    public void setTypeCodeName(String typeCodeName) {
        this.typeCodeName = typeCodeName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getImageFullUrl() {
        return imageFullUrl;
    }

    public void setImageFullUrl(String imageFullUrl) {
        this.imageFullUrl = imageFullUrl;
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

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public String getStrStartTime() {
        return strStartTime;
    }

    public void setStrStartTime(String strStartTime) {
        this.strStartTime = strStartTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStrEndTime() {
        return strEndTime;
    }

    public void setStrEndTime(String strEndTime) {
        this.strEndTime = strEndTime;
    }

    public Integer getClickCount() {
        return clickCount;
    }

    public void setClickCount(Integer clickCount) {
        this.clickCount = clickCount;
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

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getAdvertisementDesc() {
        return advertisementDesc;
    }

    public void setAdvertisementDesc(String advertisementDesc) {
        this.advertisementDesc = advertisementDesc;
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

    public String getThemeType() {
        return themeType;
    }

    public void setThemeType(String themeType) {
        this.themeType = themeType;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public String getH5PageType() {
        return h5PageType;
    }

    public void setH5PageType(String h5PageType) {
        this.h5PageType = h5PageType;
    }

}