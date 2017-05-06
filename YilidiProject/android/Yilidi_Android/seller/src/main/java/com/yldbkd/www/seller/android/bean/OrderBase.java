package com.yldbkd.www.seller.android.bean;

import com.yldbkd.www.seller.android.utils.Constants;

/**
 * 订单基础信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class OrderBase extends BaseModel {

    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 配送方式：
     * 1-送货上门
     * 2-自提
     * 见Constants.DeliveryMode
     */
    private Integer deliveryModeCode = Constants.DeliveryMode.DELIVER_GOODS;
    /**
     * 订单创建时间
     */
    private String createTime;
    /**
     * 订单付款时间
     */
    private String payTime;
    /**
     * 订单金额
     */
    private Long totalAmount;
    /**
     * 应付金额
     */
    private Long payableAmount;
    /**
     * 订单状态
     */
    private Integer statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;
    /**
     * 自提客户联系电话
     */
    private String buyerMobile;
    /**
     * 地址信息
     */
    private ConsigneeAddress consigneeAddress;

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getStatusCode() {
        return statusCode == null ? 1 : statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public ConsigneeAddress getConsigneeAddress() {
        return consigneeAddress;
    }

    public void setConsigneeAddress(ConsigneeAddress consigneeAddress) {
        this.consigneeAddress = consigneeAddress;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public String getBuyerMobile() {
        return buyerMobile;
    }

    public void setBuyerMobile(String buyerMobile) {
        this.buyerMobile = buyerMobile;
    }

    public Long getPayableAmount() {
        return payableAmount;
    }

    public void setPayableAmount(Long payableAmount) {
        this.payableAmount = payableAmount;
    }
}
