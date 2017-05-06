package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：系统公告历史记录实体类，映射系统域表YiLiDiSystemCenter.S_SYSTEM_ANNOUNCEMENT_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SystemAnnouncementHistory extends BaseModel {
	private static final long serialVersionUID = 4749962737811134327L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 关联公告表的公告ID
	 */
	private Integer announceId;
	/**
	 * 公告主题
	 */
	private String title;
	/**
	 * 排序
	 */
	private Integer sort;
	/**
	 * 状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSANNOUNCESTATUS)
	 */
	private String stateCode;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作用户ID
	 */
	private Integer operateUserId;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSANNOUNCEOPERTYPE)
	 */
	private String operateType;
	/**
	 * 备注信息
	 */
	private String note;
	/**
	 * 公告内容
	 */
	private String content;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getAnnounceId() {
		return announceId;
	}

	public void setAnnounceId(Integer announceId) {
		this.announceId = announceId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getStateCode() {
		return stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}