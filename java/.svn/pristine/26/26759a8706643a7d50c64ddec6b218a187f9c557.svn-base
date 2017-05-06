package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 调货单状态历史
 * 
 * @author simpson
 * 
 */
public class FlittingOrderHistoryDto extends BaseDto {

    private static final long serialVersionUID = 997348423523126406L;
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
