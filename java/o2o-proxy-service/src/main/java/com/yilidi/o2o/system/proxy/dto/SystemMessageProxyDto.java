package com.yilidi.o2o.system.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

public class SystemMessageProxyDto extends BaseDto{
	private static final long serialVersionUID = 1L;
	/**
	 * '消息ID'
	 */
	private Integer id;
	/**
	 * '消息类型,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGETYPE的内容'
	 */
	private String messageType;
	/**
	 * 消息类型组
	 */
	private String messageTypeGroup;
	/**
	 * 消息类型名称
	 */
	private String messageTypeName;
	/**
	 * '消息标题'
	 */
	private String messageTitle;
	/**
	 * '消息图片(url）'
	 */
	private String messageImage;
	/**
	 * '消息简介'
	 */
	private String messageIntro;
	/**
	 * '消息内容'
	 */
	private String messageContent;
	/**
	 * '跳转类型,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGESKIPTYPE的内容'
	 */
	private String skipType;
	/**
	 * 跳转类型名称
	 */
	private String skipTypeName;
	/**
	 * '跳转对象'
	 */
	private String skipObject;
	
	private String skipObjectName;
	/**
	 * '发布对象,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGEPUBLISHOBJECT的内容'
	 */
	private String publishObject;
	/**
	 * 发布对象名称
	 */
	private String publishObjectName;
	/**
	 * '发布对象值（用逗号分隔）'
	 */
	private String publishObjectValue;
	
	private String publishObjectValueNames;
	/**
	 * '添加人'
	 */
	private Integer addUser;
	/**
	 * '天假时间'
	 */
	private Date addTime;
	/**
	 * '修改人'
	 */
	private Integer updateUser;
	/**
	 * '修改时间'
	 */
	private Date updateTime;
	/**
	 * '审核状态,对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=MESSAGECHECKSTATUS的内容'
	 */
	private String checkStatus;
	/**
	 * 审核状态名称
	 */
	private String checkStatusName;
	/**
	 * '审核人'
	 */
	private Integer checkUser;
	/**
	 * '审核时间'
	 */
	private Date checkTime;
	/**
	 * '审核不通过原因'
	 */
	private String checkReason;
	/**
	 * 排序id
	 */
	private Integer sortId;
	/**
     * 被删除的图片URL
     */
    private String delImageUrl;
    /**
     * 图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlag;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getMessageType() {
		return messageType;
	}
	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}
	public String getMessageTypeGroup() {
		return messageTypeGroup;
	}
	public void setMessageTypeGroup(String messageTypeGroup) {
		this.messageTypeGroup = messageTypeGroup;
	}
	public String getMessageTypeName() {
		return messageTypeName;
	}
	public void setMessageTypeName(String messageTypeName) {
		this.messageTypeName = messageTypeName;
	}
	public String getMessageTitle() {
		return messageTitle;
	}
	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}
	public String getMessageImage() {
		return messageImage;
	}
	public void setMessageImage(String messageImage) {
		this.messageImage = messageImage;
	}
	public String getMessageIntro() {
		return messageIntro;
	}
	public void setMessageIntro(String messageIntro) {
		this.messageIntro = messageIntro;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public String getSkipType() {
		return skipType;
	}
	public void setSkipType(String skipType) {
		this.skipType = skipType;
	}
	public String getSkipTypeName() {
		return skipTypeName;
	}
	public void setSkipTypeName(String skipTypeName) {
		this.skipTypeName = skipTypeName;
	}
	public String getSkipObject() {
		return skipObject;
	}
	public void setSkipObject(String skipObject) {
		this.skipObject = skipObject;
	}
	public String getSkipObjectName() {
		return skipObjectName;
	}
	public void setSkipObjectName(String skipObjectName) {
		this.skipObjectName = skipObjectName;
	}
	public String getPublishObject() {
		return publishObject;
	}
	public void setPublishObject(String publishObject) {
		this.publishObject = publishObject;
	}
	public String getPublishObjectName() {
		return publishObjectName;
	}
	public void setPublishObjectName(String publishObjectName) {
		this.publishObjectName = publishObjectName;
	}
	public String getPublishObjectValue() {
		return publishObjectValue;
	}
	public void setPublishObjectValue(String publishObjectValue) {
		this.publishObjectValue = publishObjectValue;
	}
	public String getPublishObjectValueNames() {
		return publishObjectValueNames;
	}
	public void setPublishObjectValueNames(String publishObjectValueNames) {
		this.publishObjectValueNames = publishObjectValueNames;
	}
	public Integer getAddUser() {
		return addUser;
	}
	public void setAddUser(Integer addUser) {
		this.addUser = addUser;
	}
	public Date getAddTime() {
		return addTime;
	}
	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}
	public Integer getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(Integer updateUser) {
		this.updateUser = updateUser;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getCheckStatus() {
		return checkStatus;
	}
	public void setCheckStatus(String checkStatus) {
		this.checkStatus = checkStatus;
	}
	public String getCheckStatusName() {
		return checkStatusName;
	}
	public void setCheckStatusName(String checkStatusName) {
		this.checkStatusName = checkStatusName;
	}
	public Integer getCheckUser() {
		return checkUser;
	}
	public void setCheckUser(Integer checkUser) {
		this.checkUser = checkUser;
	}
	public Date getCheckTime() {
		return checkTime;
	}
	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}
	public String getCheckReason() {
		return checkReason;
	}
	public void setCheckReason(String checkReason) {
		this.checkReason = checkReason;
	}
	public Integer getSortId() {
		return sortId;
	}
	public void setSortId(Integer sortId) {
		this.sortId = sortId;
	}
	public String getDelImageUrl() {
		return delImageUrl;
	}
	public void setDelImageUrl(String delImageUrl) {
		this.delImageUrl = delImageUrl;
	}
	public String getImageFlag() {
		return imageFlag;
	}
	public void setImageFlag(String imageFlag) {
		this.imageFlag = imageFlag;
	}
}
