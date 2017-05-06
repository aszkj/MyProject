package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.UserRole;

/**
 * 功能描述：用户角色关联关系数据操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface UserRoleMapper {

	/**
	 * 根据roleId删除所有的用户角色关联关系
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_USER_ROLE })
	Integer deleteByRoleId(Integer roleId);

	/**
	 * 根据用户ID删除所有的用户角色关联关系
	 * 
	 * @param userId
	 *            用户ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_USER_ROLE })
	Integer deleteByUserId(Integer userId);

	/**
	 * 保存用户角色关联关系
	 * 
	 * @param record
	 *            关联关系对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_USER_ROLE })
	Integer save(UserRole record);

	/**
	 * 根据用户ID查询所有的用户角色关联关系
	 * 
	 * @param userId
	 *            用户ID
	 * @return 用户角色关联关系对象列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_USER_ROLE })
	List<UserRole> listByUserId(Integer userId);

	/**
	 * 根据角色ID查询所有的用户角色关联关系
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 用户角色关联关系对象列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_USER_ROLE })
	List<UserRole> listByRoleId(Integer roleId);

}