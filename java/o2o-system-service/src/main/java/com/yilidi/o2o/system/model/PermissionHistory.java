package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(权限历史实体类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:25:00
 * 
 */
public class PermissionHistory extends BaseModel {
	private static final long serialVersionUID = 2606117006165583784L;

	/**
	 * id, 自增主键
	 */
	private Integer id;

	/**
	 * 关联权限表的权限Id
	 */
	private Integer permissionId;

	/**
	 * 父节点ID
	 */
	private Integer parentId;
	/**
	 * 权限资源的名称
	 */
	private String permissionName;
	/**
	 * 权限资源父资源的名称
	 */
	private String parentName;
	/**
	 * 权限资源的类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PERMISSIONTYPE)
	 */
	private String permissionType;
	/**
	 * 用户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
	 */
	private String customerType;
	/**
	 * 权限编码
	 */
	private String permissionCode;
	/**
	 * 权限级别，一级菜单、二级菜单、功能。
	 */
	private String permissionLevel;
	/**
	 * 排序
	 */
	private Integer sort;
	/**
	 * 权限url
	 */
	private String permissionUrl;
	/**
	 * 权限状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PERMISSIONSTATUS)
	 */
	private String permissionStatus;
	/**
	 * 操作用户ID
	 */
	private Integer operateUserId;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PERMISSIONOPERTYPE)
	 */
	private String operateType;
	/**
	 * 权限资源描述
	 */
	private String permissionDesc;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getPermissionType() {
		return permissionType;
	}

	public void setPermissionType(String permissionType) {
		this.permissionType = permissionType;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getPermissionCode() {
		return permissionCode;
	}

	public void setPermissionCode(String permissionCode) {
		this.permissionCode = permissionCode;
	}

	public String getPermissionLevel() {
		return permissionLevel;
	}

	public void setPermissionLevel(String permissionLevel) {
		this.permissionLevel = permissionLevel;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getPermissionUrl() {
		return permissionUrl;
	}

	public void setPermissionUrl(String permissionUrl) {
		this.permissionUrl = permissionUrl;
	}

	public String getPermissionStatus() {
		return permissionStatus;
	}

	public void setPermissionStatus(String permissionStatus) {
		this.permissionStatus = permissionStatus;
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

	public String getPermissionDesc() {
		return permissionDesc;
	}

	public void setPermissionDesc(String permissionDesc) {
		this.permissionDesc = permissionDesc;
	}

}