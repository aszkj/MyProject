package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：系统公告实体类，映射系统域表YiLiDiSystemCenter.S_SYSTEM_ANNOUNCEMENT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SystemAnnouncement extends BaseModel {
	private static final long serialVersionUID = -2292740249791670594L;

	/**
	 * 公告ID， 自增主键
	 */
	private Integer id;

	/**
	 * 公告标题
	 */
	private String title;

	/**
	 * 公告内容
	 */
	private String content;
	/**
	 * 排序
	 */
	private Integer sort;
	/**
	 * 公告状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSANNOUNCESTATUS)
	 */
	private String stateCode;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 备注信息
	 */
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
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

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}