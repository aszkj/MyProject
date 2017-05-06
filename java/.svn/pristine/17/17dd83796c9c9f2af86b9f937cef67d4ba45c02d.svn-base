package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 调货单状态历史，映射交易域表YiLiDiOrderCenter.T_FLITTING_ORDER_HISTORY
 * 
 * @author simpson
 * 
 */
public class FlittingOrderHistory extends BaseModel {

    private static final long serialVersionUID = 118907911615159038L;
    /**
     * 状态跟踪ID，主键自增
     */
    private Integer id;
    /**
     * 调拨单编号
     */
    private String flittingOrderNo;
    /**
     * 操作用户ID
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 调拨单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=FLITTINGORDERSTATUS)
     */
    private String flittingStatus;
    /**
     * 操作描述
     */
    private String operationDesc;

    /**
     * 默认构造器
     */
    public FlittingOrderHistory() {
    }

    /**
     * 带变量构造器
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @param operateTime
     *            操作时间
     * @param flittingStatus
     *            调拨单状态
     * @param operationDesc
     *            操作说明
     */
    public FlittingOrderHistory(String flittingOrderNo, Integer operateUserId, Date operateTime, String flittingStatus,
            String operationDesc) {
        this.flittingOrderNo = flittingOrderNo;
        this.operateUserId = operateUserId;
        this.operateTime = operateTime;
        this.flittingStatus = flittingStatus;
        this.operationDesc = operationDesc;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFlittingOrderNo() {
        return flittingOrderNo;
    }

    public void setFlittingOrderNo(String flittingOrderNo) {
        this.flittingOrderNo = flittingOrderNo;
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

    public String getFlittingStatus() {
        return flittingStatus;
    }

    public void setFlittingStatus(String flittingStatus) {
        this.flittingStatus = flittingStatus;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

}
