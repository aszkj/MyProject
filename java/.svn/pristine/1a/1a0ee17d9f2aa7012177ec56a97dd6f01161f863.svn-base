package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 短信通知消息Dto
 * 
 * @Description:TODO(短信通知消息Dto)
 * @author: chenlian
 * @date: 2015年10月28日 下午9:52:53
 * 
 */
public class SmsNotifyMessageDto extends BaseDto {
	private static final long serialVersionUID = 1L;

    /**
     * 通知消息ID，主键
     */
    private Integer id;
    
    /**
     * 短信消息类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SMSNOTIFYMSGTYPE)
     */
    private String smsMsgType;

    /**
     * 短信接收者(电话号码)
     */
    private String toUser;

    /**
     * 短信内容
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
     * 消息回执状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=NOTIFYMSGREPORTSTATUS)
     */
    private String reportStatus;
    
    /**
     * 发送消息的IP地址
     */
    private String remoteIpAddr;
    
    /**
     * 短信消息提供方类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SMSNOTIFYPROVIDETYPE)
     */
    private String smsProvideType;

    /**
     * 消息平台的JOBID
     */
    private String smsJobId;

    /**
     * 消息回执更新时间
     */
    private Date reportTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSmsMsgType() {
        return smsMsgType;
    }

    public void setSmsMsgType(String smsMsgType) {
        this.smsMsgType = smsMsgType;
    }

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
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

    public String getReportStatus() {
        return reportStatus;
    }

    public void setReportStatus(String reportStatus) {
        this.reportStatus = reportStatus;
    }

    public String getRemoteIpAddr() {
        return remoteIpAddr;
    }

    public void setRemoteIpAddr(String remoteIpAddr) {
        this.remoteIpAddr = remoteIpAddr;
    }

    public String getSmsProvideType() {
        return smsProvideType;
    }

    public void setSmsProvideType(String smsProvideType) {
        this.smsProvideType = smsProvideType;
    }

    public String getSmsJobId() {
        return smsJobId;
    }

    public void setSmsJobId(String smsJobId) {
        this.smsJobId = smsJobId;
    }

    public Date getReportTime() {
        return reportTime;
    }

    public void setReportTime(Date reportTime) {
        this.reportTime = reportTime;
    }

}
