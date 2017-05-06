package com.yilidi.o2o.sessionmodel.buyer.order;

import java.io.Serializable;
import java.util.List;

/**
 * 功能描述：订单结算商品列表信息缓存类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class OrderSessionModel implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Integer userId;

    /** 收货地址ID **/
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
     * 配送方式
     */
    private Integer deliveryModeCode;
    /**
     * 店铺ID
     */
    private Integer storeId;

    private List<OrderItemSessionModel> orderItemSessionModelList;

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
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

    public List<OrderItemSessionModel> getOrderItemSessionModelList() {
        return orderItemSessionModelList;
    }

    public void setOrderItemSessionModelList(List<OrderItemSessionModel> orderItemSessionModelList) {
        this.orderItemSessionModelList = orderItemSessionModelList;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
