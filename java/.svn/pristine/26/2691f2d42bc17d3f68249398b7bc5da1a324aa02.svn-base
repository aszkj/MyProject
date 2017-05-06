package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(角色与权限关联关系历史实体类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:28:16
 * 
 */
public class RolePermissionHistory extends BaseModel {
	private static final long serialVersionUID = 493454370680351600L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 角色ID
	 */
	private Integer roleId;
	/**
	 * 权限列表，由权限资源ID（菜单、按钮等）组成，每个权限通过英文下逗号(,)分割
	 */
	private String permissionIds;
	/**
	 * 操作用户ID
	 */
	private Integer operateUserId;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=ROLEPERMISSIONOPERTYPE)
	 */
	private String operateType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public String getPermissionIds() {
		return permissionIds;
	}

	public void setPermissionIds(String permissionIds) {
		this.permissionIds = permissionIds;
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