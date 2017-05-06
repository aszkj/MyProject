package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

public class SellerOrderListDto extends BaseDto {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 7056421103077533610L;

    /**
     * 订单编码
     */
    private String saleOrderNo;

    /**
     * 订单创建时间
     */
    private String createTime;

    /**
     * 订单付款时间
     */
    private String payTime;

    /**
     * 商品金额
     */
    private Long totalAmount;

    /**
     * 应付金额
     */
    private Long payableAmount;

    /**
     * 用户名称
     */
    private String consignee;

    /**
     * 手机号
     */
    private String consMobile;

    /**
     * 地址信息
     */
    private String consAddress;

    /**
     * 送货距离单位米
     */
    private Integer distance;

    /**
     * 配送方式
     */
    private String deliveryMode;

    /**
     * 下单的用户ID
     */
    private Integer userId;

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

    public Long getPayableAmount() {
        return payableAmount;
    }

    public void setPayableAmount(Long payableAmount) {
        this.payableAmount = payableAmount;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getConsMobile() {
        return consMobile;
    }

    public void setConsMobile(String consMobile) {
        this.consMobile = consMobile;
    }

    public String getConsAddress() {
        return consAddress;
    }

    public void setConsAddress(String consAddress) {
        this.consAddress = consAddress;
    }

    public Integer getDistance() {
        return distance;
    }

    public void setDistance(Integer distance) {
        this.distance = distance;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

}
