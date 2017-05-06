package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：发货记录实体类，映射交易域表YiLiDiOrderCenter.T_SEND_ORDER <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SendOrder extends BaseModel {
    private static final long serialVersionUID = -214188536254819962L;
    /**
     * 发货ID，主键自增
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 此次发货的物流单号，多个单号使用逗号分开
     */
    private String logisticsNo;
    /**
     * 零售商ID，关联用户域客户表U_CUSTOMER的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_BUYER）
     */
    private Integer retailerId;
    /**
     * 发货时间
     */
    private Date sendTime;
    /**
     * 发货操作用户ID
     */
    private Integer sendUserId;
    /**
     * 发货备注
     */
    private String note;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getLogisticsNo() {
        return logisticsNo;
    }

    public void setLogisticsNo(String logisticsNo) {
        this.logisticsNo = logisticsNo;
    }

    public Integer getRetailerId() {
        return retailerId;
    }

    public void setRetailerId(Integer retailerId) {
        this.retailerId = retailerId;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Integer getSendUserId() {
        return sendUserId;
    }

    public void setSendUserId(Integer sendUserId) {
        this.sendUserId = sendUserId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}