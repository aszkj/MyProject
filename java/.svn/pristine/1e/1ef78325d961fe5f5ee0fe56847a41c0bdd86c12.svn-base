package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.PermissionHistory;

/**
 * 功能描述：权限资源数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface PermissionHistoryMapper {
	/**
	 * 保存的权限资源历史记录
	 * 
	 * @param record
	 *            历史记录
	 * @return 影响的行数
	 */
	Integer save(PermissionHistory record);

	/**
	 * 查询所有的历史资源
	 * 
	 * @return 历史资源列表
	 */
	List<PermissionHistory> list();

	/**
	 * 根据权限ID查询权限历史信息
	 * 
	 * @param permissionId
	 *            权限资源ID
	 * @return 历史权限信息列表
	 */
	List<PermissionHistory> listByPermissionId(Integer permissionId);

	/**
	 * 根据权限名称查询权限历史信息
	 * 
	 * @param permissionName
	 *            权限名称
	 * @return 历史权限信息列表
	 */
	List<PermissionHistory> listByPermissionName(String permissionName);

}