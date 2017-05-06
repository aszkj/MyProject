package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(角色与权限关联关系DTO)
 * @author: chenlian
 * @date: 2015年11月10日 下午7:19:07
 * 
 */
public class RolePermissionDto extends BaseDto {

	private static final long serialVersionUID = -3690065757518906720L;

	/**
	 * id, 自增主键
	 */
	private Integer id;

	/**
	 * 角色ID
	 */
	private Integer roleId;
	/**
	 * 权限ID
	 */
	private Integer permissionId;

	/**
	 * 创建用户ID
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;

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

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
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

}
