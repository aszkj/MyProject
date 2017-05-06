package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 订单退款DTO
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午10:59:52
 */
public class OrderRefundDto extends BaseDto {

    private static final long serialVersionUID = -83375850884957847L;

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

    private List<OrderRefundStatusHistoryDto> orderRefundStatusHistoreyDtos;

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

    public List<OrderRefundStatusHistoryDto> getOrderRefundStatusHistoreyDtos() {
        return orderRefundStatusHistoreyDtos;
    }

    public void setOrderRefundStatusHistoreyDtos(List<OrderRefundStatusHistoryDto> orderRefundStatusHistoreyDtos) {
        this.orderRefundStatusHistoreyDtos = orderRefundStatusHistoreyDtos;
    }

}
