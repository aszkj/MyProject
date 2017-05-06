package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 调货单明细，映射交易域表YiLiDiOrderCenter.T_FLITTING_ORDER_ITEM
 * 
 * @author simpson
 * 
 */
public class FlittingOrderItemHistory extends BaseModel {

    private static final long serialVersionUID = -1766954744126554788L;
    /**
     * 调拨单明细数量变化表ID，主键自增
     */
    private Integer id;
    /**
     * 调拨单明细ID
     */
    private Integer flittingOrderItemId;
    /**
     * 调拨单数量变化表ID
     */
    private Integer flittingOrderRejectId;
    /**
     * 修改前调拨接收数量
     */
    private Integer oriReceiveQuantity;
    /**
     * 修改前调拨拒绝数量
     */
    private Integer oriRejectQuantity;
    /**
     * 修改后调拨接收数量
     */
    private Integer receiveQuantity;
    /**
     * 修改后调拨拒绝数量
     */
    private Integer rejectQuantity;
    /**
     * 调拨明细数量变化操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=FLITTINGORDERITEMHISOPERTYPE)
     */
    private String operateType;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作用户id
     */
    private Integer operateUserId;
    /**
     * 操作说明
     */
    private String operateDesc;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFlittingOrderItemId() {
        return flittingOrderItemId;
    }

    public void setFlittingOrderItemId(Integer flittingOrderItemId) {
        this.flittingOrderItemId = flittingOrderItemId;
    }

    public Integer getFlittingOrderRejectId() {
        return flittingOrderRejectId;
    }

    public void setFlittingOrderRejectId(Integer flittingOrderRejectId) {
        this.flittingOrderRejectId = flittingOrderRejectId;
    }

    public Integer getOriReceiveQuantity() {
        return oriReceiveQuantity;
    }

    public void setOriReceiveQuantity(Integer oriReceiveQuantity) {
        this.oriReceiveQuantity = oriReceiveQuantity;
    }

    public Integer getOriRejectQuantity() {
        return oriRejectQuantity;
    }

    public void setOriRejectQuantity(Integer oriRejectQuantity) {
        this.oriRejectQuantity = oriRejectQuantity;
    }

    public Integer getReceiveQuantity() {
        return receiveQuantity;
    }

    public void setReceiveQuantity(Integer receiveQuantity) {
        this.receiveQuantity = receiveQuantity;
    }

    public Integer getRejectQuantity() {
        return rejectQuantity;
    }

    public void setRejectQuantity(Integer rejectQuantity) {
        this.rejectQuantity = rejectQuantity;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

    public String getOperateDesc() {
        return operateDesc;
    }

    public void setOperateDesc(String operateDesc) {
        this.operateDesc = operateDesc;
    }

}
