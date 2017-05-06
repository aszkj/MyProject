package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：系统站内消息实体类，映射系统域表YiLiDiSystemCenter.S_SITE_MESSAGE <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SiteMessageHistory extends BaseModel {
	private static final long serialVersionUID = 7754118624203279952L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 关联站内消息的消息ID
	 */
	private Integer siteMessageId;
	/**
	 * 消息主题
	 */
	private String subject;
	/**
	 * 发送消息的用户ID,关联用户域U_USER表的USERID字段， 系统创建为0
	 */
	private Integer sendId;
	/**
	 * 接收者， 以逗号和分号分割。相同类别以逗号分割，不同类别以分号分割
	 */
	private String receive;
	/**
	 * 消息状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SITEMSGSTATUS)
	 */
	private String statusCode;
	/**
	 * 消息类别，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SITEMSGTYPE)
	 */
	private String messageType;
	/**
	 * 发送次数
	 */
	private Integer sendCount;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作用户的ID
	 */
	private Integer operateUserId;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SITEMSGOPERTYPE)
	 */
	private String operateType;
	/**
	 * 消息内容
	 */
	private String content;

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

	public Integer getSendId() {
		return sendId;
	}

	public void setSendId(Integer sendId) {
		this.sendId = sendId;
	}

	public String getReceive() {
		return receive;
	}

	public void setReceive(String receive) {
		this.receive = receive;
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

	public Integer getSendCount() {
		return sendCount;
	}

	public void setSendCount(Integer sendCount) {
		this.sendCount = sendCount;
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

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}