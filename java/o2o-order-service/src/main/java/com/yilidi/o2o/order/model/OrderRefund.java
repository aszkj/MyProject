package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 订单退款表，映射交易域表YiLiDiOrderCenter.T_ORDER_REFUND
 * 
 * @author: chenb
 * @date: 2016年10月18日 下午5:53:42
 */
public class OrderRefund extends BaseModel {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * ID，主键自增
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 退款金额
     */
    private Long refundAmount;
    /**
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;
    /**
     * 退款方式,关联系统字典DICTTYPE=ORDERREFUNDWAY
     */
    private String refundWay;
    /**
     * 退款状态,关联系统字典DICTTYPE=ORDERREFUNDSTATUS
     */
    private String status;
    /**
     * 退款原因
     */
    private String refundReason;
    /**
     * 退款失败原因
     */
    private String refundRejectReason;
    /**
     * 创建记录用户ID
     */
    private Integer createUserId;
    /**
     * 创建记录时间
     */
    private Date createTime;
    /**
     * 修改记录用户ID
     */
    private Integer modifyUserId;
    /**
     * 修改记录时间
     */
    private Date modifyTime;

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

    public Long getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(Long refundAmount) {
        this.refundAmount = refundAmount;
    }

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
    }

    public String getRefundWay() {
        return refundWay;
    }

    public void setRefundWay(String refundWay) {
        this.refundWay = refundWay;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getRefundReason() {
        return refundReason;
    }

    public void setRefundReason(String refundReason) {
        this.refundReason = refundReason;
    }

    public String getRefundRejectReason() {
        return refundRejectReason;
    }

    public void setRefundRejectReason(String refundRejectReason) {
        this.refundRejectReason = refundRejectReason;
    }

}
