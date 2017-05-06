package com.yilidi.o2o.appvo.buyer.system;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 用户消息列表
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:40:34
 */
public class UserMessageListVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /** 消息ID **/
    private Integer siteMessageId;
    /** 消息标题 **/
    private String subject;
    /** 消息类型编码 **/
    private String messageType;
    /** 消息类型名称 **/
    private String messageName;
    /**
     * 消息是否是新消息 0-否 1-是
     **/
    private Integer statusCode;
    /** 消息时间 **/
    private String createTime;
    /** 消息内容 **/
    private String content;

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

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getMessageName() {
        return messageName;
    }

    public void setMessageName(String messageName) {
        this.messageName = messageName;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
