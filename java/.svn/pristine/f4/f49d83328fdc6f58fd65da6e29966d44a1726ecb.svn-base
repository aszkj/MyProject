package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.UserRoleHistory;

/**
 * 功能描述：用户角色关联关系历史记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface UserRoleHistoryMapper {

	/**
	 * 保存历史记录
	 * 
	 * @param record
	 *            记录实体
	 * @return 影响的行数
	 */
	Integer save(UserRoleHistory record);

	/**
	 * 查询所有的历史记录
	 * 
	 * @return 历史记录列表
	 */
	List<UserRoleHistory> list();

	/**
	 * 根据用户ID查询所有的历史记录
	 * 
	 * @param userId
	 *            用户ID
	 * @return 历史记录列表
	 */
	List<UserRoleHistory> listByUserId(Integer userId);

}