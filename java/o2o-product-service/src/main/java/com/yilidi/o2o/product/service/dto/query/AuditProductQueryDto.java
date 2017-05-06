package com.yilidi.o2o.product.service.dto.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 数据包产品查询DTO
 * 
 * @author: chenlian
 * @date: 2016年12月9日 下午7:23:35
 */
public class AuditProductQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 7040048190980459488L;

    /**
     * 批次号
     */
    private String batchNo;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 产品类别编码
     */
    private String productClassCode;
    /**
     * 品牌编码
     */
    private String brandCode;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 品牌编码列表
     */
    private String brandCodeList;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 审核状态
     */
    private String auditStatus;
    /**
     * 初审状态列表
     */
    private List<String> initAuditStatusList;
    /**
     * 终审状态列表
     */
    private List<String> finalAuditStatusList;
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
    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getBrandCodeList() {
        return brandCodeList;
    }

    public void setBrandCodeList(String brandCodeList) {
        this.brandCodeList = brandCodeList;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
    }

    public List<String> getInitAuditStatusList() {
        return initAuditStatusList;
    }

    public void setInitAuditStatusList(List<String> initAuditStatusList) {
        this.initAuditStatusList = initAuditStatusList;
    }

    public List<String> getFinalAuditStatusList() {
        return finalAuditStatusList;
    }

    public void setFinalAuditStatusList(List<String> finalAuditStatusList) {
        this.finalAuditStatusList = finalAuditStatusList;
    }

}
