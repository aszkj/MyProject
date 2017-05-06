package com.yilidi.o2o.system.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 
 * @Description:TODO(角色查询实体类)
 * @author: chenlian
 * @date: 2015年11月13日 下午5:58:20
 * 
 */
public class RoleQuery extends BaseQuery {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = 6068491345021464729L;

	/**
	 * 角色ID
	 */
	private Integer id;
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
	 * 关联客户域表U_CUSTOMER的CUSTOMERID字段， 标识该角色的是属于那个客户的（终端用户（买家），店铺（卖家），运营商（平台运营机构））
	 */
	private Integer customerId;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

}
