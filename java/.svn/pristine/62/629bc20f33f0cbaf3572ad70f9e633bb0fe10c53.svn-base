package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 采购单入库单关联信息，映射交易域表YiLiDiOrderCenter.T_PURCHASE_STOCKIN_RELATION
 * 
 * @author chenb
 * 
 */
public class PurchaseStockInRelation extends BaseModel {

    private static final long serialVersionUID = -2468660078614677309L;
    /**
     * 采购单入库信息关联ID，主键自增
     */
    private Integer id;
    /**
     * 采购入库操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PURCHASESTOCKINOPERTYPE)
     */
    private String purchaseOperType;
    /**
     * 采购单编号
     */
    private String purchaseOrderNo;
    /**
     * 入库单ID
     */
    private Integer stockInId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPurchaseOperType() {
        return purchaseOperType;
    }

    public void setPurchaseOperType(String purchaseOperType) {
        this.purchaseOperType = purchaseOperType;
    }

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
    }

    public Integer getStockInId() {
        return stockInId;
    }

    public void setStockInId(Integer stockInId) {
        this.stockInId = stockInId;
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

}
