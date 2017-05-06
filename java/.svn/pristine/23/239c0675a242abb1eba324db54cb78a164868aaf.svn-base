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
public class SiteMessage extends BaseModel {
	private static final long serialVersionUID = -3508297315679418029L;
	/**
	 * 消息ID，自增主键
	 */
	private Integer id;
	/**
	 * 消息主题
	 */
	private String subject;
	/**
	 * 发送者ID
	 */
	private Integer sendId;
	/**
	 * 接收者： 以逗号和分号分割。相同类别以逗号分割，不同类别以分号分割
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
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}