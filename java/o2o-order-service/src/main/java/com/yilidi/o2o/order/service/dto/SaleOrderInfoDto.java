package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

public class SaleOrderInfoDto extends BaseDto {

    private static final long serialVersionUID = 2816420058181124071L;
    /**
     * 订单ID
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 门店名称
     */
    private String storeName;
    /**
     * 下单的用户账号
     */
    private String userName;
    /**
     * 门店编号
     */
    private String storeCode;
    /**
     * 配送方式
     */
    private String deliveryMode;
    /**
     * 配送方式名称
     */
    private String deliveryModeName;
    /**
     * 收货人姓名
     */
    private String consigneeUserName;
    /**
     * 收货人的详细地址
     */
    private String addressDetail;
    /**
     * 收货人电话
     */
    private String phoneNo;
    /**
     * 订单总金额
     */
    private Long totalAmount;
    /**
     * 总运费，单位为厘
     */
    private Long transferFee;
    /**
     * 优惠券使用的金额，单位为厘
     */
    private Long preferentialAmt;
    /**
     * 下单时间
     */
    private Date createTime;
    /**
     * 付款状态
     */
    private String payStatus;
    /**
     * 支付时间
     */
    private Date payTime;
    /**
     * 订单支付方式
     */
    private String payTypeCode;
    /**
     * 订单支付方式名称
     */
    private String payTypeName;
    /**
     * 订单状态
     */
    private String statusCode;
    /**
     * 订单名称
     */
    private String statusName;

    /**
     * 订单类型
     */
    private String orderType;

    /**
     * 订单渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 渠道名称
     */
    private String channelName;

    /**
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;
    /**
     * 支付平台名称
     */
    private String payPlatformName;
    /**
     * 评价时间
     */
    private Date appraiseTime;
    /**
     * 评价操作人
     */
    private Integer appraiseUserId;
    /**
     * 订单是否已评价，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=APPRAISEFLAG)
     */
    private String appraiseFlag;

    
    public String getAppraiseFlag() {
        return appraiseFlag;
    }

    public void setAppraiseFlag(String appraiseFlag) {
        this.appraiseFlag = appraiseFlag;
    }

    public Date getAppraiseTime() {
        return appraiseTime;
    }

    public void setAppraiseTime(Date appraiseTime) {
        this.appraiseTime = appraiseTime;
    }

    public Integer getAppraiseUserId() {
        return appraiseUserId;
    }

    public void setAppraiseUserId(Integer appraiseUserId) {
        this.appraiseUserId = appraiseUserId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public String getDeliveryModeName() {
        return deliveryModeName;
    }

    public void setDeliveryModeName(String deliveryModeName) {
        this.deliveryModeName = deliveryModeName;
    }

    public String getConsigneeUserName() {
        return consigneeUserName;
    }

    public void setConsigneeUserName(String consigneeUserName) {
        this.consigneeUserName = consigneeUserName;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Long getTransferFee() {
        return transferFee;
    }

    public void setTransferFee(Long transferFee) {
        this.transferFee = transferFee;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
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

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getChannelName() {
        return channelName;
    }

    public void setChannelName(String channelName) {
        this.channelName = channelName;
    }

    public String getPayPlatformName() {
        return payPlatformName;
    }

    public void setPayPlatformName(String payPlatformName) {
        this.payPlatformName = payPlatformName;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

}
