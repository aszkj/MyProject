package com.yilidi.o2o.system.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

public class SystemMessageQueryDto extends BaseQueryDto {
	private static final long serialVersionUID = 1L;

	/**
	 * '消息类型,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGETYPE的内容'
	 */
	private String messageType;
	
	/**
	 * '消息标题'
	 */
	private String messageTitle;
	
	/**
	 * '发布对象,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容'
	 */
	private String publishObject;
	
	/**
	 * '审核状态,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGECHECKSTATUS的内容'
	 */
	private String checkStatus;
	/**
	 * 排序id
	 */
	private Integer sortId;
	/**
	 * 用户注册时间
	 */
	private Date createTime;


	public String getMessageTitle() {
		return messageTitle;
	}

	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}

	public String getPublishObject() {
		return publishObject;
	}

	public void setPublishObject(String publishObject) {
		this.publishObject = publishObject;
	}

	public String getCheckStatus() {
		return checkStatus;
	}

	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}

	public Integer getSortId() {
		return sortId;
	}

	public void setSortId(Integer sortId) {
		this.sortId = sortId;
	}

	public String getMessageType() {
		return messageType;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}
