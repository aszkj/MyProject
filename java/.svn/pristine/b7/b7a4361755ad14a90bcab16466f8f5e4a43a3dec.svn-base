package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(邮件通知消息实体类，映射数据库表 YiLiDiSystemCenter.S_EMAIL_NOTIFY_MESSAGE)
 * @author: chenlian
 * @date: 2015-9-18 下午10:03:39
 * 
 */
public class EmailNotifyMessage extends BaseModel {

	private static final long serialVersionUID = 7440994473710650760L;

	/**
	 * 通知消息ID
	 */
	private Integer id;

	/**
	 * 邮件主题
	 */
	private String subject;

	/**
	 * 邮件发送者(电话号码)
	 */
	private String fromUser;

	/**
	 * 邮件接收者(电话号码)
	 */
	private String toUser;

	/**
	 * 邮件内容
	 */
	private String content;

	/**
	 * 发送时间
	 */
	private Date sendTime;

	/**
	 * 消息状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=NOTIFYMSGSTATUS)
	 */
	private String messageStatus;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
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

}