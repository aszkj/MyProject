package com.yilidi.o2o.order.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

public class ThemeProxyDto extends BaseDto {
	private static final long serialVersionUID = 1L;

	/**
     * 专题ID，自增主键
     */
    private Integer id;

    /**
     * 专题名称
     */
    private String themeName;

    /**
     * 专题类型编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=SALEZONETYPE)
     */
    private String typeCode;

    /**
     * 专题类型编码名称
     */
    private String typeCodeName;

    /**
     * 专题图片URL
     */
    private String themeImageUrl;

    /**
     * 专题图片全URL
     */
    private String themeImageFullUrl;

    /**
     * 专题slogan图片URL
     */
    private String sloganImageUrl;

    /**
     * 专题slogan图片全URL
     */
    private String sloganImageFullUrl;

    /**
     * 专题底色编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=THEMEBASECOLORTYPE)
     */
    private String baseColor;

    /**
     * 专题图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlagForThemeImage;

    /**
     * 被删除的专题图片URL
     */
    private String delImageUrlForThemeImage;

    /**
     * 专题slogan图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlagForSloganImage;

    /**
     * 被删除的专题slogan图片URL
     */
    private String delImageUrlForSloganImage;

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

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
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

    public String getThemeImageUrl() {
        return themeImageUrl;
    }

    public void setThemeImageUrl(String themeImageUrl) {
        this.themeImageUrl = themeImageUrl;
    }

    public String getThemeImageFullUrl() {
        return themeImageFullUrl;
    }

    public void setThemeImageFullUrl(String themeImageFullUrl) {
        this.themeImageFullUrl = themeImageFullUrl;
    }

    public String getSloganImageUrl() {
        return sloganImageUrl;
    }

    public void setSloganImageUrl(String sloganImageUrl) {
        this.sloganImageUrl = sloganImageUrl;
    }

    public String getSloganImageFullUrl() {
        return sloganImageFullUrl;
    }

    public void setSloganImageFullUrl(String sloganImageFullUrl) {
        this.sloganImageFullUrl = sloganImageFullUrl;
    }

    public String getBaseColor() {
        return baseColor;
    }

    public void setBaseColor(String baseColor) {
        this.baseColor = baseColor;
    }

    public String getImageFlagForThemeImage() {
        return imageFlagForThemeImage;
    }

    public void setImageFlagForThemeImage(String imageFlagForThemeImage) {
        this.imageFlagForThemeImage = imageFlagForThemeImage;
    }

    public String getDelImageUrlForThemeImage() {
        return delImageUrlForThemeImage;
    }

    public void setDelImageUrlForThemeImage(String delImageUrlForThemeImage) {
        this.delImageUrlForThemeImage = delImageUrlForThemeImage;
    }

    public String getImageFlagForSloganImage() {
        return imageFlagForSloganImage;
    }

    public void setImageFlagForSloganImage(String imageFlagForSloganImage) {
        this.imageFlagForSloganImage = imageFlagForSloganImage;
    }

    public String getDelImageUrlForSloganImage() {
        return delImageUrlForSloganImage;
    }

    public void setDelImageUrlForSloganImage(String delImageUrlForSloganImage) {
        this.delImageUrlForSloganImage = delImageUrlForSloganImage;
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
