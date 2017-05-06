package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 调拨单数量变化
 * 
 * @author simpson
 * 
 */
public class FlittingOrderRejectDto extends BaseDto {

    private static final long serialVersionUID = -6141114793050646640L;
    /**
     * 调拨单数量变化表ID，主键自增
     */
    private Integer id;
    /**
     * 调拨单编号
     */
    private String flittingOrderNo;
    /**
     * 实际调拨数量
     */
    private Integer oriRealFlittingCount;
    /**
     * 实际调拨商品金额，单位为厘
     */
    private Long oriRealFlittingAmount;
    /**
     * 实际调拨数量
     */
    private Integer realFlittingCount;
    /**
     * 实际调拨商品金额，单位为厘
     */
    private Long realFlittingAmount;
    /**
     * 调拨数量变化操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=FLITTINGORDERHISOPERTYPE)
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
    
    /**
     * 调拨商品明细历史列表
     */
    private List<FlittingOrderItemHistoryDto> flittingOrderItemHistoryDtoList;

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

    public Integer getOriRealFlittingCount() {
        return oriRealFlittingCount;
    }

    public void setOriRealFlittingCount(Integer oriRealFlittingCount) {
        this.oriRealFlittingCount = oriRealFlittingCount;
    }

    public Long getOriRealFlittingAmount() {
        return oriRealFlittingAmount;
    }

    public void setOriRealFlittingAmount(Long oriRealFlittingAmount) {
        this.oriRealFlittingAmount = oriRealFlittingAmount;
    }

    public Integer getRealFlittingCount() {
        return realFlittingCount;
    }

    public void setRealFlittingCount(Integer realFlittingCount) {
        this.realFlittingCount = realFlittingCount;
    }

    public Long getRealFlittingAmount() {
        return realFlittingAmount;
    }

    public void setRealFlittingAmount(Long realFlittingAmount) {
        this.realFlittingAmount = realFlittingAmount;
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

    public List<FlittingOrderItemHistoryDto> getFlittingOrderItemHistoryDtoList() {
        return flittingOrderItemHistoryDtoList;
    }

    public void setFlittingOrderItemHistoryDtoList(List<FlittingOrderItemHistoryDto> flittingOrderItemHistoryDtoList) {
        this.flittingOrderItemHistoryDtoList = flittingOrderItemHistoryDtoList;
    }

}
