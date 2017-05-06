package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 购物车
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午10:59:52
 */
public class ShopCartDto extends BaseDto {

    private static final long serialVersionUID = 1L;
    /**
     * 购物车ID，自增主键
     */
    private Integer id;
    /**
     * 用户ID,关联用户域U_USER表的USERID字段
     */
    private Integer userId;
    /**
     * 客户ID
     */
    private Integer customerId;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 活动ID
     */
    private Integer activityId;

    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 商品数量
     */
    private Integer quantity;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 商品图片
     */
    private String saleProductImageUrl;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 普通会员价格
     */
    private Long retailPrice;
    /**
     * 会员价格
     */
    private Long promotionalPrice;

    /**
     * 是否有效商品标志
     */
    private String enabledFlag;
    /**
     * 库存
     */
    private Integer remainCount;
    /**
     * 产品上下架状态
     */
    private String saleStatus;
    /**
     * 限购数量
     */
    private Integer limitCount;

    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date createTime;
    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date modifyTime;
    /**
     * 设备ID
     */
    private String deviceId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

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

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public String getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(String enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public Integer getLimitCount() {
        return limitCount;
    }

    public void setLimitCount(Integer limitCount) {
        this.limitCount = limitCount;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

}
