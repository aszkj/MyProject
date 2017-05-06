package com.yilidi.o2o.system.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：已发布到用户的消息实体，映射系统域表YiLiDiSystemCenter.S_SITE_MESSAGE_PUBLISHED <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SiteMessagePublished extends BaseModel {
	private static final long serialVersionUID = -7652721353600747239L;
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
}