package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(角色历史DTO)
 * @author: chenlian
 * @date: 2015年11月7日 下午5:06:37
 * 
 */
public class RoleHistoryDto extends BaseDto {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = -9017405479543040049L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 角色Id
	 */
	private Integer roleId;
	/**
	 * 角色名称
	 */
	private String roleName;
	/**
	 * 用户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
	 */
	private String customerType;
	/**
	 * 角色描述
	 */
	private String roleDesc;
	/**
	 * 客户Id
	 */
	private Integer customerId;
	/**
	 * 操作用户Id
	 */
	private Integer operateUserId;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=ROLEOPERTYPE)
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

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getRoleDesc() {
		return roleDesc;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
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
