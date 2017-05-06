package com.yilidi.o2o.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.Role;
import com.yilidi.o2o.system.service.dto.query.RoleQuery;

/**
 * 功能描述：角色数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface RoleMapper {
	/**
	 * 保存角色信息
	 * 
	 * @param record
	 *            角色对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE })
	Integer save(Role record);

	/**
	 * 根据角色ID，删除角色信息
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE })
	Integer deleteById(Integer roleId);

	/**
	 * 根据ID更新角色信息
	 * 
	 * @param record
	 *            角色对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE })
	Integer updateById(Role record);

	/**
	 * 根据ID更新角色信息(如果字段值为null，则不更新，推荐使用该方法进行更新)
	 * 
	 * @param record
	 *            角色对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE })
	Integer updateByIdSelective(Role record);

	/**
	 * 根据id加载角色信息
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 角色对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE })
	Role loadById(Integer roleId);

	/**
	 * 根据不同条件加载角色信息列表
	 * 
	 * @param role
	 *            角色实体
	 * @return 角色列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE })
	List<Role> listRoles(Role role);

	/**
	 * 根据用户类型加载角色信息列表
	 * 
	 * @param customerType
	 *            用户类型
	 * @return 角色列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE })
	List<Role> listByCustomerType(String customerType);

	/**
	 * 根据不同条件分页加载角色信息列表
	 * 
	 * @param roleQuery
	 *            角色查询实体
	 * @return 角色列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE })
	Page<Role> findRoles(RoleQuery roleQuery);

	/**
	 * 根据角色名称和客户类型获取角色信息
	 * 
	 * @param roleName
	 *            角色名
	 * @param customerType
	 *            用户类型
	 * @return 角色对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE })
	Role loadRoleByNameAndCustomerType(@Param("roleName") String roleName, @Param("customerType") String customerType);
}