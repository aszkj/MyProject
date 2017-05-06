package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 推送通知消息实体DTO
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午12:49:08
 */
public class PushNotifyMessageDto extends BaseDto {

    private static final long serialVersionUID = 7440994473710650760L;

    /**
     * 通知消息ID，主键
     */
    private Integer id;

    /**
     * 推送消息类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PUSHNOTIFYMSGTYPE)
     */
    private String pushMsgType;

    /**
     * 推送接收者(ID)
     */
    private Integer toUser;

    /**
     * 推送内容
     */
    private String content;

    /**
     * 发送时间
     */
    private Date sendTime;

    /**
     * 消息发送状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=NOTIFYMSGSTATUS)
     */
    private String messageStatus;

    /**
     * 推送消息提供方类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PUSHNOTIFYPROVIDETYPE)
     */
    private String pushProvideType;

    /**
     * 消息平台的JOBID
     */
    private String pushJobId;
    /**
     * 推送失败原因
     */
    private String failureReason;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPushMsgType() {
        return pushMsgType;
    }

    public void setPushMsgType(String pushMsgType) {
        this.pushMsgType = pushMsgType;
    }

    public Integer getToUser() {
        return toUser;
    }

    public void setToUser(Integer toUser) {
        this.toUser = toUser;
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

    public String getMessageStatus() {
        return messageStatus;
    }

    public void setMessageStatus(String messageStatus) {
        this.messageStatus = messageStatus;
    }

    public String getPushProvideType() {
        return pushProvideType;
    }

    public void setPushProvideType(String pushProvideType) {
        this.pushProvideType = pushProvideType;
    }

    public String getPushJobId() {
        return pushJobId;
    }

    public void setPushJobId(String pushJobId) {
        this.pushJobId = pushJobId;
    }

    public String getFailureReason() {
        return failureReason;
    }

    public void setFailureReason(String failureReason) {
        this.failureReason = failureReason;
    }

}