package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：订单实体类，映射交易域表YiLiDiOrderCenter.T_SALE_ORDER <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrder extends BaseModel {
    private static final long serialVersionUID = 4793313993215745060L;
    /**
     * 订单ID，主键自增
     */
    private Integer id;
    /**
     * 订单编号，可调用StringUtils.generateOrderNo()生成
     */
    private String saleOrderNo;
    /**
     * 买家CUSTOMERID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_BUYER）
     */
    private Integer buyerCustomerId;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;

    /**
     * 下单的用户ID，如果是买家用户就是买家的用户ID，如果后台有操作的，则为后台或者店家的登录用户ID
     */
    private Integer userId;
    /**
     * 订单类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERTYPE)
     */
    private String typeCode;
    /**
     * 订单状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERSTATUS)
     */
    private String statusCode;
    /**
     * 订单渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 收货码
     */
    private String receiveCode;
    /**
     * 订购总数量
     */
    private Integer orderCount;
    /**
     * 总价钱, 每款产品数量*产品单价 的总和，单位为厘
     */
    private Long totalAmount;
    /**
     * 总运费，单位为厘
     */
    private Long transferFee;
    /**
     * 配送方式，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERDELIVERYMODE)
     */
    private String deliveryMode;
    /**
     * 配送时间要求，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERBESTTIME)
     */
    private String bestTime;
    /**
     * 订单创建时间
     */
    private Date createTime;
    /**
     * 订单创建人ID
     */
    private Integer createUserId;
    /**
     * 省份编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String proviceCode;
    /**
     * 市编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String cityCode;
    /**
     * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String countyCode;
    /**
     * 订单支付方式编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYTYPE)
     */
    private String payTypeCode;
    /**
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;
    /**
     * 付款时间
     */
    private Date payTime;
    /**
     * 付款状态
     */
    private String payStatus;
    /**
     * 接单时间
     */
    private Date acceptTime;
    /**
     * 接单用户ID
     */
    private Integer acceptUserId;
    /**
     * 发货状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERSENDSTATUS)
     */
    private String sendStatus;
    /**
     * 发货时间
     */
    private Date sendTime;
    /**
     * 发货数量
     */
    private Integer sendCount;
    /**
     * 发货人
     */
    private Integer sendUserId;

    /**
     * 收货状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERTAKESTATUS)
     */
    private String takeStatus;
    /**
     * 收货时间
     */
    private Date takeTime;
    /**
     * 收货操作人
     */
    private Integer takeUserId;
    /**
     * 买家留言
     */
    private String leaveMessage;
    /**
     * 备注信息
     */
    private String note;
    /**
     * 取消订单类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CANCELTYPECODE)
     */
    private String cancelTypeCode;
    /**
     * 优惠券使用的金额，单位为厘
     */
    private Long preferentialAmt;
    /**
     * 使用的优惠券编号
     */
    private String conCode;
    /**
     * 订单取消原因，根据类型得到的原因，取消订单类型为“其它原因”时，该字段为客户填写内容
     */
    private String cancelReason;
    /**
     * 订单取消时间
     */
    private Date cancelTime;
    /**
     * 订单取消人
     */
    private Integer cancelUserId;
    /**
     * 退款审核时间
     */
    private Date refundAuditTime;
    /**
     * 退款审核用户ID
     */
    private Integer refundAuditUserId;
    /**
     * 退款审核不通过原因
     */
    private String refundAuditFailureReason;

    /**
     * 会员账号
     */
    private String userName;

    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 店铺编号
     */
    private String storeCode;

    /**
     * 欧币抵扣金额，单位为厘
     */
    private Long obAmount;

    /**
     * 订单总的销售佣金费用，单位为厘
     */
    private Long commissionAmount;
    /**
     * 订单总的计算销售佣金的商品数量
     */
    private Integer commissionCount;
    /**
     * 生成订单时使用的设备唯一标识符
     */
    private String deviceId;
    /**
     * 推广客户ID
     */
    private Integer recommendCustomerId;
    /**
     * 用户优惠券ID,多个用逗号隔开
     */
    private String userCouponId;
    /**
     * 用户抵用券ID,多个用逗号隔开
     */
    private String userVoucherId;
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

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
    }

    public String getCancelTypeCode() {
        return cancelTypeCode;
    }

    public void setCancelTypeCode(String cancelTypeCode) {
        this.cancelTypeCode = cancelTypeCode;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public String getConCode() {
        return conCode;
    }

    public void setConCode(String conCode) {
        this.conCode = conCode;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取订单编号
     * 
     * @return 订单编号
     */
    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Integer getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
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

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }

    public String getBestTime() {
        return bestTime;
    }

    public void setBestTime(String bestTime) {
        this.bestTime = bestTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public String getProviceCode() {
        return proviceCode;
    }

    public void setProviceCode(String proviceCode) {
        this.proviceCode = proviceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public Date getPayTime() {
        return payTime;
    }

    public void setPayTime(Date payTime) {
        this.payTime = payTime;
    }

    public String getSendStatus() {
        return sendStatus;
    }

    public void setSendStatus(String sendStatus) {
        this.sendStatus = sendStatus;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Integer getSendCount() {
        return sendCount;
    }

    public void setSendCount(Integer sendCount) {
        this.sendCount = sendCount;
    }

    public String getTakeStatus() {
        return takeStatus;
    }

    public void setTakeStatus(String takeStatus) {
        this.takeStatus = takeStatus;
    }

    public Date getTakeTime() {
        return takeTime;
    }

    public void setTakeTime(Date takeTime) {
        this.takeTime = takeTime;
    }

    public Integer getTakeUserId() {
        return takeUserId;
    }

    public void setTakeUserId(Integer takeUserId) {
        this.takeUserId = takeUserId;
    }

    public String getLeaveMessage() {
        return leaveMessage;
    }

    public void setLeaveMessage(String leaveMessage) {
        this.leaveMessage = leaveMessage;
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

    public Long getObAmount() {
        return obAmount;
    }

    public void setObAmount(Long obAmount) {
        this.obAmount = obAmount;
    }

    public Long getCommissionAmount() {
        return commissionAmount;
    }

    public void setCommissionAmount(Long commissionAmount) {
        this.commissionAmount = commissionAmount;
    }

    public Integer getCommissionCount() {
        return commissionCount;
    }

    public void setCommissionCount(Integer commissionCount) {
        this.commissionCount = commissionCount;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public Date getAcceptTime() {
        return acceptTime;
    }

    public void setAcceptTime(Date acceptTime) {
        this.acceptTime = acceptTime;
    }

    public Integer getAcceptUserId() {
        return acceptUserId;
    }

    public void setAcceptUserId(Integer acceptUserId) {
        this.acceptUserId = acceptUserId;
    }

    public Integer getSendUserId() {
        return sendUserId;
    }

    public void setSendUserId(Integer sendUserId) {
        this.sendUserId = sendUserId;
    }

    public Integer getCancelUserId() {
        return cancelUserId;
    }

    public void setCancelUserId(Integer cancelUserId) {
        this.cancelUserId = cancelUserId;
    }

    public String getReceiveCode() {
        return receiveCode;
    }

    public void setReceiveCode(String receiveCode) {
        this.receiveCode = receiveCode;
    }

    public Date getRefundAuditTime() {
        return refundAuditTime;
    }

    public void setRefundAuditTime(Date refundAuditTime) {
        this.refundAuditTime = refundAuditTime;
    }

    public Integer getRefundAuditUserId() {
        return refundAuditUserId;
    }

    public void setRefundAuditUserId(Integer refundAuditUserId) {
        this.refundAuditUserId = refundAuditUserId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public Integer getRecommendCustomerId() {
        return recommendCustomerId;
    }

    public void setRecommendCustomerId(Integer recommendCustomerId) {
        this.recommendCustomerId = recommendCustomerId;
    }

    public String getUserCouponId() {
        return userCouponId;
    }

    public void setUserCouponId(String userCouponId) {
        this.userCouponId = userCouponId;
    }

    public String getUserVoucherId() {
        return userVoucherId;
    }

    public void setUserVoucherId(String userVoucherId) {
        this.userVoucherId = userVoucherId;
    }

    public String getRefundAuditFailureReason() {
        return refundAuditFailureReason;
    }

    public void setRefundAuditFailureReason(String refundAuditFailureReason) {
        this.refundAuditFailureReason = refundAuditFailureReason;
    }

}