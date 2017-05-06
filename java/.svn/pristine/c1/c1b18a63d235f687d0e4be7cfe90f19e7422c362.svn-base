package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 出库单状态历史
 * 
 * @author chenb
 * 
 */
public class StockOutOrderHistoryDto extends BaseDto {
    private static final long serialVersionUID = -7076693709476981047L;
    /**
     * 状态跟踪ID，主键自增
     */
    private Integer id;
    /**
     * 出库单编号
     */
    private String stockOutOrderNo;
    /**
     * 操作用户ID
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 出库单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=STOCKOUTORDERSTATUS)
     */
    private String orderStatus;
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

    public String getStockOutOrderNo() {
        return stockOutOrderNo;
    }

    public void setStockOutOrderNo(String stockOutOrderNo) {
        this.stockOutOrderNo = stockOutOrderNo;
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

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

}
