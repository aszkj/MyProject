package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 订单赠品信息 ，映射交易域表YiLiDiOrderCenter.T_ORDER_GIFT_INFO
 * 
 * @author chenb
 * 
 */
public class OrderGiftInfo extends BaseModel {

    private static final long serialVersionUID = 7888259938582041186L;
    /**
     * 表ID
     */
    private Integer id;
    /**
     * 赠品ID
     */
    private Integer giftId;
    /**
     * 赠品类型,关联系统字典DICTTYPE=ORDERGIFTTYPE
     */
    private String giftType;
    /**
     * 赠品数量
     */
    private Integer giftCount;
    /**
     * 活动类型,关联系统字典DICTTYPE=ACTIVITYTYPE
     */
    private String activityType;
    /**
     * 订单编号
     */
    private String orderNo;
    /**
     * 赠品发送状态,关联系统字典DICTTYPE=ORDERGIFTSTATUS
     */
    private String orderGiftStatus;
    /**
     * 修改用户ID
     */
    private Integer createUserId;
    /**
     * 创建记录时间
     */
    private Date createTime;
    /**
     * 修改记录用户ID
     */
    private Integer modifyUserId;
    /**
     * 修改记录时间
     */
    private Date modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGiftId() {
        return giftId;
    }

    public void setGiftId(Integer giftId) {
        this.giftId = giftId;
    }

    public String getGiftType() {
        return giftType;
    }

    public void setGiftType(String giftType) {
        this.giftType = giftType;
    }

    public Integer getGiftCount() {
        return giftCount;
    }

    public void setGiftCount(Integer giftCount) {
        this.giftCount = giftCount;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderGiftStatus() {
        return orderGiftStatus;
    }

    public void setOrderGiftStatus(String orderGiftStatus) {
        this.orderGiftStatus = orderGiftStatus;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

}
