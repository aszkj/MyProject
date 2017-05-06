package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 采购单状态历史，映射交易域表YiLiDiOrderCenter.T_PURCHASE_ORDER_HISTORY
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderHistory extends BaseModel {

    private static final long serialVersionUID = 118907911615159038L;
    /**
     * 状态跟踪ID，主键自增
     */
    private Integer id;
    /**
     * 采购单编号
     */
    private String purchaseOrderNo;
    /**
     * 操作用户ID
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 采购单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PURCHASEORDERSTATUS)
     */
    private String purchaseStatus;
    /**
     * 操作描述
     */
    private String operationDesc;

    /**
     * 默认构造器
     */
    public PurchaseOrderHistory() {
    }

    /**
     * 带变量构造器
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @param purchaseStatus
     *            采购单状态
     * @param operationDesc
     *            操作说明
     */
    public PurchaseOrderHistory(String purchaseOrderNo, Integer operateUserId, Date operateTime, String purchaseStatus,
            String operationDesc) {
        this.purchaseOrderNo = purchaseOrderNo;
        this.operateUserId = operateUserId;
        this.operateTime = operateTime;
        this.purchaseStatus = purchaseStatus;
        this.operationDesc = operationDesc;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
    }

    public String getPurchaseStatus() {
        return purchaseStatus;
    }

    public void setPurchaseStatus(String purchaseStatus) {
        this.purchaseStatus = purchaseStatus;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

}
