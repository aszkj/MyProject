package com.yilidi.o2o.order.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 购物车查询条件
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午11:55:13
 */
public class ShopCartQuery extends BaseQuery {

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
     * 店铺ID
     */
    private Integer storeId;
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
     * 渠道编码
     */
    private String channelCode;
    /**
     * 设备ID
     */
    private String deviceId;

    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date createTime;
    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date modifyTime;

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

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
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

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

}
