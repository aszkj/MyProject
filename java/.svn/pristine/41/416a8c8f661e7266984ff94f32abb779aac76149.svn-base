package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 已发布消息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午11:03:25
 * 
 */
public class SiteMessagePublishedDto extends BaseDto {
    private static final long serialVersionUID = 1L;
    /**
     * 主键id，自增
     */
    private Integer id;
    /**
     * 站内消息ID， 关联系统域表S_SITE_MESSAGE的SITEMESSAGEID字段
     */
    private Integer siteMessageId;
    /**
     * 消息主题
     */
    private String subject;
    /**
     * 消息接收者
     */
    private Integer receiveId;
    /**
     * 消息状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SITEMSGPUBSTATUS)
     */
    private String statusCode;
    /**
     * 消息类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SITEMSGTYPE)
     */
    private String messageType;
    
    // 站内消息属性
    /**
     * 发送消息的用户ID
     */
    private Integer sendId;
    /**
     * 消息内容
     */
    private String content;

    /**
     * 创建消息时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSiteMessageId() {
        return siteMessageId;
    }

    public void setSiteMessageId(Integer siteMessageId) {
        this.siteMessageId = siteMessageId;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Integer getReceiveId() {
        return receiveId;
    }

    public void setReceiveId(Integer receiveId) {
        this.receiveId = receiveId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public Integer getSendId() {
        return sendId;
    }

    public void setSendId(Integer sendId) {
        this.sendId = sendId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}
