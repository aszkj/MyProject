package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：催付款短信日志记录表，映射交易域表YiLiDiOrderCenter.T_ORDER_REMINDER_PAY_MESSAGE <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class OrderReminderPayMessage extends BaseModel {

    private static final long serialVersionUID = 17076577271738176L;
    /**
     * 记录编号，主键
     */
    private Integer id;
    /**
     * 发送手机号码
     */
    private String toUser;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 短信内容
     */
    private String content;
    /**
     * 发送时间
     */
    private Date sendTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

}