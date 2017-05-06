package com.yilidi.o2o.product.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 数据包产品图片属性模型DTO
 * 
 * @author: chenlian
 * @date: 2016年12月17日 下午15:01:10
 */
public class AuditProductImageProfileDto extends BaseDto {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 7463311177064561038L;

    private static final Integer DEFAULT_IMAGEORDER = 1;

    public AuditProductImageProfileDto() {
        this.appPicOrder = DEFAULT_IMAGEORDER;
    }

    /**
     * 数据包产品ID
     */
    private Integer auditProductId;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 产品图片id
     */
    private Integer appPicId;
    /**
     * APP产品图片路径
     */
    private String appPicPath;
    /**
     * APP产品图片位置
     */
    private Integer appPicSort;
    /**
     * APP产品图片顺序
     */
    private Integer appPicOrder;
    /**
     * APP主图
     */
    private Integer appPicMain;
    /**
     * APP产品图片增加标示
     */
    private String appImageFlag;
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

    public Integer getAppPicId() {
        return appPicId;
    }

    public void setAppPicId(Integer appPicId) {
        this.appPicId = appPicId;
    }

    public String getAppPicPath() {
        return appPicPath;
    }

    public void setAppPicPath(String appPicPath) {
        this.appPicPath = appPicPath;
    }

    public Integer getAppPicSort() {
        return appPicSort;
    }

    public void setAppPicSort(Integer appPicSort) {
        this.appPicSort = appPicSort;
    }

    public Integer getAppPicOrder() {
        return appPicOrder;
    }

    public void setAppPicOrder(Integer appPicOrder) {
        this.appPicOrder = appPicOrder;
    }

    public Integer getAppPicMain() {
        return appPicMain;
    }

    public void setAppPicMain(Integer appPicMain) {
        this.appPicMain = appPicMain;
    }

    public String getAppImageFlag() {
        return appImageFlag;
    }

    public void setAppImageFlag(String appImageFlag) {
        this.appImageFlag = appImageFlag;
    }

}