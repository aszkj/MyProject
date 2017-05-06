package com.yldbkd.www.buyer.android.bean;

/**
 * 订单基本信息数据
 * <p/>
 * Created by linghuxj on 15/10/15.
 */
public class OrderBase extends BaseModel {
    /**
     * 订单ID
     */
    private Integer saleOrderId;
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
     * 支付方式名称
     */
    private String payTypeName;
    /**
     * 支付类型Code
     */
    private String payTypeCode;
    /**
     * 订单状态
     */
    private String statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;
    /**
     * 配送方式名称
     */
    private String deliveryModeName;
    /**
     * 配送方式编码  1-送货上门 2-自提
     */
    private Integer deliveryModeCode;
    /**
     * 订单已付金额
     */
    private Long paidAmount;
    /**
     * 送货时间说明
     */
    private String deliveryTimeNote;
    /**
     * 收货码
     */
    private String receiveCode;
    /**
     * 备注
     */
    private String note;
    /**
     * 是否评价状态：
     * 0：未评价（默认，在订单状态已完成情况下即可评价）
     * 1：已评价
     */
    private Integer isEvaluated = 0;

    public Integer getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(Integer saleOrderId) {
        this.saleOrderId = saleOrderId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
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

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
    }

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getDeliveryModeName() {
        return deliveryModeName;
    }

    public void setDeliveryModeName(String deliveryModeName) {
        this.deliveryModeName = deliveryModeName;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getDeliveryTimeNote() {
        return deliveryTimeNote;
    }

    public void setDeliveryTimeNote(String deliveryTimeNote) {
        this.deliveryTimeNote = deliveryTimeNote;
    }

    public Long getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(Long paidAmount) {
        this.paidAmount = paidAmount;
    }

    public String getReceiveCode() {
        return receiveCode;
    }

    public void setReceiveCode(String receiveCode) {
        this.receiveCode = receiveCode;
    }

    public Integer getIsEvaluated() {
        return isEvaluated;
    }

    public void setIsEvaluated(Integer isEvaluated) {
        this.isEvaluated = isEvaluated;
    }
}
