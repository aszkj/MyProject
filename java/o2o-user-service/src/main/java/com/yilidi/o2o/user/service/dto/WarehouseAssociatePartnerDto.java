package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 微仓关联合伙人信息DTO
 * 
 * @author: chenlian
 * @date: 2016年6月29日 下午2:02:36
 */
public class WarehouseAssociatePartnerDto extends BaseDto {

    private static final long serialVersionUID = 2768830166091073688L;

    /**
     * 门店ID
     */
    private Integer storeId;

    /**
     * 门店名称
     */
    private String storeName;

    /**
     * 门店编码
     */
    private String storeCode;

    /**
     * 门店手机号
     */
    private String mobile;

    /**
     * 门店全地址
     */
    private String fullAddress;

    /**
     * 关联时间
     */
    private Date associateTime;

    /**
     * 销售总额
     */
    private Long finishOrderAmount;

    /**
     * 订单完成总数
     */
    private Integer finishOrderCount;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public Date getAssociateTime() {
        return associateTime;
    }

    public void setAssociateTime(Date associateTime) {
        this.associateTime = associateTime;
    }

    public Long getFinishOrderAmount() {
        return finishOrderAmount;
    }

    public void setFinishOrderAmount(Long finishOrderAmount) {
        this.finishOrderAmount = finishOrderAmount;
    }

    public Integer getFinishOrderCount() {
        return finishOrderCount;
    }

    public void setFinishOrderCount(Integer finishOrderCount) {
        this.finishOrderCount = finishOrderCount;
    }

}