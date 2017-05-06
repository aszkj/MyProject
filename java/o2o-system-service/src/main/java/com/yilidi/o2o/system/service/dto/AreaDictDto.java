package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(区域字典DTO)
 * @author: chenlian
 * @date: 2015年12月3日 下午4:08:07
 * 
 */
public class AreaDictDto extends BaseDto {

	private static final long serialVersionUID = -7210716428126208072L;

	/**
	 * 区域ID
	 */
	private Integer id;

	/**
	 * 区域名称
	 */
	private String areaName;

	/**
	 * 区域类别，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=AREATYPE)
	 */
	private String areaType;

	/**
	 * 父级编码，如果没有父级地区，则该字段为0
	 */
	private String parentCode;

	/**
	 * 父级区域类别
	 */
	private String parentAreaType;

	/**
	 * 区域编码
	 */
	private String areaCode;

	/**
	 * 创建用户ID
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;

	/**
	 * 修改时间
	 */
	private Date modifyTime;

	/**
	 * 区域树中该节点的唯一标识nid
	 */
	private String areaTreeNid;

	/**
	 * 区域树中该节点是否被展开
	 */
	private boolean areaTreeExpanded;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

	public String getAreaType() {
		return areaType;
	}

	public void setAreaType(String areaType) {
		this.areaType = areaType;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public String getParentAreaType() {
		return parentAreaType;
	}

	public void setParentAreaType(String parentAreaType) {
		this.parentAreaType = parentAreaType;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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

	public String getAreaTreeNid() {
		return areaTreeNid;
	}

	public void setAreaTreeNid(String areaTreeNid) {
		this.areaTreeNid = areaTreeNid;
	}

	public boolean isAreaTreeExpanded() {
		return areaTreeExpanded;
	}

	public void setAreaTreeExpanded(boolean areaTreeExpanded) {
		this.areaTreeExpanded = areaTreeExpanded;
	}

}
