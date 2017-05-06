package com.yilidi.o2o.user.service.dto;

/**
 * 
 * @Description:TODO(角色绑定的用户信息DTO)
 * @author: chenlian
 * @date: 2015年12月10日 上午12:59:22
 * 
 */
public class RoleBindingUserInfoDto extends UserBaseDto {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -3120273768654559243L;

	/**
	 * 真实姓名
	 */
	private String realName;

	/**
	 * 电子邮箱
	 */
	private String email;

	/**
	 * 所在部门
	 */
	private String department;

	/**
	 * 所在部门名称
	 */
	private String departmentName;

	/**
	 * 用户状态编码
	 */
	private String statusCode;

	/**
	 * 用户状态名称
	 */
	private String statusName;

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

}