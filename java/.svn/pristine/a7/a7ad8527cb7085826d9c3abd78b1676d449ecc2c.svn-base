package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(退款申请DTO)
 * @author: chenlian
 * @date: 2016年6月17日 下午8:17:48
 */
public class RefundApplyDto extends BaseDto {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 4538525475605236698L;

    /**
     * 申请退款id，自增主键
     */
    private Integer id;

    /**
     * 退款申请用户id
     */
    private Integer applyUserId;

    /**
     * 申请人客户ID，即买家所属客户ID
     */
    private Integer buyerCustomerId;

    /**
     * 退款金额，单位厘
     */
    private Long refundAmount;

    /**
     * 订单编号
     */
    private String saleOrderNo;

    /**
     * 卖家所属客户ID
     */
    private Integer storeId;

    /**
     * 退款申请的状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=REFUNDAPPLYSTATUS)
     */
    private String statusCode;

    /**
     * 退款申请时间
     */
    private Date applyTime;

    /**
     * 申请消息
     */
    private String message;

    /**
     * 操作时间
     */
    private Date operationTime;

    /**
     * 操作用户id
     */
    private Integer operationUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getApplyUserId() {
        return applyUserId;
    }

    public void setApplyUserId(Integer applyUserId) {
        this.applyUserId = applyUserId;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
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

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Date applyTime) {
        this.applyTime = applyTime;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Long getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(Long refundAmount) {
        this.refundAmount = refundAmount;
    }

    public Date getOperationTime() {
        return operationTime;
    }

    public void setOperationTime(Date operationTime) {
        this.operationTime = operationTime;
    }

    public Integer getOperationUserId() {
        return operationUserId;
    }

    public void setOperationUserId(Integer operationUserId) {
        this.operationUserId = operationUserId;
    }

}