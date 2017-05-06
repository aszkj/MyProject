package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(用户与角色关联关系历史实体类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:28:16
 * 
 */
public class UserRoleHistory extends BaseModel {
	private static final long serialVersionUID = 493454370680351600L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 用户ID
	 */
	private Integer userId;
	/**
	 * 角色列表，由角色ID组成，每个权限通过英文下逗号(,)分割
	 */
	private String roleIds;
	/**
	 * 操作用户ID
	 */
	private Integer operateUserId;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERROLEOPERTYPE)
	 */
	private String operateType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public Integer getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(Integer operateUserId) {
		this.operateUserId = operateUserId;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

}