package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 订单列表信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class OrderList extends BaseModel {

    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 订单时间
     */
    private String createTime;
    /**
     * 订单状态
     */
    private String statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;
    /**
     * 订单图片URL(订单内第一个商品图片URL)
     */
    private List<OrderImage> orderImageList;
    /**
     * 订单商品总数量
     */
    private Integer quantity;
    /**
     * 订单金额
     */
    private Long totalAmount;
    /**
     * 配送方式  1-送货上门 2-自提
     */
    private Integer deliveryModeCode;
    /**
     * 是否评价状态：
     * 0：未评价（默认，在订单状态已完成情况下即可评价）
     * 1：已评价
     */
    private Integer isEvaluated = 0;

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
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

    public List<OrderImage> getOrderImageList() {
        return orderImageList;
    }

    public void setOrderImageList(List<OrderImage> orderImageList) {
        this.orderImageList = orderImageList;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public Integer getIsEvaluated() {
        return isEvaluated;
    }

    public void setIsEvaluated(Integer isEvaluated) {
        this.isEvaluated = isEvaluated;
    }
}
