package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 采购单状态历史
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderHistoryDto extends BaseDto {

    private static final long serialVersionUID = 1727898499466928967L;
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

    public String getPurchaseStatus() {
        return purchaseStatus;
    }

    public void setPurchaseStatus(String purchaseStatus) {
        this.purchaseStatus = purchaseStatus;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

}
