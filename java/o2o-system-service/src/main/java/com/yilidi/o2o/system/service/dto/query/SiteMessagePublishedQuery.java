package com.yilidi.o2o.system.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 发布消息查询实体类
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午11:12:30
 * 
 */
public class SiteMessagePublishedQuery extends BaseQuery {

    private static final long serialVersionUID = 1L;

    /**
     * 接收消息的用户ID
     */
    private Integer receiveId;
    /** 消息类别 **/
    private String messageType;
    /** 消息状态 **/
    private String statusCode;
    /** 站内消息ID **/
    private Integer siteMessageId;
    /** 发消息用户ID **/
    private Integer sendId;

    public Integer getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(Integer receiveId) {
        this.receiveId = receiveId;
    }

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Integer getSiteMessageId() {
        return siteMessageId;
    }

    public void setSiteMessageId(Integer siteMessageId) {
        this.siteMessageId = siteMessageId;
    }

    public Integer getSendId() {
        return sendId;
    }

    public void setSendId(Integer sendId) {
        this.sendId = sendId;
    }

}
