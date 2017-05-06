package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：退款申请历史记录实体类型，映射交易域表YiLiDiOrderCenter.T_REFUND_APPLY_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class RefundApplyHistory extends BaseModel {
    private static final long serialVersionUID = -7237376291352334304L;
    /**
     * 记录id， 自增主键
     */
    private Integer id;
    /**
     * 申请ID
     */
    private Integer applyId;
    /**
     * 申请人ID
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
     * 退款申请状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=REFUNDAPPLYSTATUS)
     */
    private String statusCode;
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
    /**
     * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=REFUNDAPPLYOPERTYPE)
     */
    private String operateType;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getApplyId() {
        return applyId;
    }

    public void setApplyId(Integer applyId) {
        this.applyId = applyId;
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

    public Long getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(Long refundAmount) {
        this.refundAmount = refundAmount;
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

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
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

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

}