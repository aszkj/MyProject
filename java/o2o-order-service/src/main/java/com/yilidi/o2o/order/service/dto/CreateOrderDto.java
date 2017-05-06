package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 生成订单
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午10:59:52
 */
public class CreateOrderDto extends BaseDto {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 客户类型ID
     */
    private Integer customerId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 收货地址ID
     */
    private Integer addressId;

    /**
     * 经度
     */
    private String longitude;
    /**
     * 纬度
     */
    private String latitude;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 配送方式
     */
    private String deliveryMode;
    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 商品列表信息
     */
    private List<CreateOrderItemDto> createOrderItemDtos;

    /**
     * 订单备注
     */
    private String note;
    /**
     * 设备号（客户端唯一标识符）
     */
    private String deviceId;
    /**
     * 优惠券ID列表
     */
    private List<Integer> userCouponIdList;
    /**
     * 抵用券ID列表
     */
    private List<Integer> userVoucherIdList;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public List<CreateOrderItemDto> getCreateOrderItemDtos() {
        return createOrderItemDtos;
    }

    public void setCreateOrderItemDtos(List<CreateOrderItemDto> createOrderItemDtos) {
        this.createOrderItemDtos = createOrderItemDtos;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public List<Integer> getUserCouponIdList() {
        return userCouponIdList;
    }

    public void setUserCouponIdList(List<Integer> userCouponIdList) {
        this.userCouponIdList = userCouponIdList;
    }

    public List<Integer> getUserVoucherIdList() {
        return userVoucherIdList;
    }

    public void setUserVoucherIdList(List<Integer> userVoucherIdList) {
        this.userVoucherIdList = userVoucherIdList;
    }

}
