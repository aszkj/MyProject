package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.RoleHistory;

/**
 * 功能描述：角色历史数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface RoleHistoryMapper {

	/**
	 * 保存角色历史信息
	 * 
	 * @param record
	 *            角色历史记录
	 * @return 影响行数
	 */
	Integer save(RoleHistory record);

	/**
	 * 查询所有的角色历史信息
	 * 
	 * @return 历史信息列表
	 */
	List<RoleHistory> list();

	/**
	 * 根据角色id查询历史信息
	 * 
	 * @param roleId
	 *            角色Id
	 * @return 历史信息列表
	 */
	List<RoleHistory> listByRoleId(Integer roleId);

	/**
	 * 根据角色名称查询历史信息
	 * 
	 * @param roleName
	 *            角色名称
	 * @return 历史信息列表
	 */
	List<RoleHistory> listByRoleName(String roleName);

}