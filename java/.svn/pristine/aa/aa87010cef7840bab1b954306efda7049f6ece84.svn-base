package com.yilidi.o2o.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.Permission;
import com.yilidi.o2o.system.model.RolePermission;

/**
 * 功能描述：角色权限关联关系数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface RolePermissionMapper {
	/**
	 * 根据权限Id删除角色权限关联关系 使用缓存时需要通知DBTablesName.S_PERMISSION, 更新用户权限数据的缓存
	 * 
	 * @param permissionId
	 *            权限Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE_PERMISSION })
	Integer deleteByPermissionId(Integer permissionId);

	/**
	 * 根据角色ID删除角色权限关联关系 使用缓存时需要通知DBTablesName.S_PERMISSION, 更新用户权限数据的缓存
	 * 
	 * @param roleId
	 *            角色Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE_PERMISSION })
	Integer deleteByRoleId(Integer roleId);

	/**
	 * 保存角色权限关联关系，保存后生成的主键可以通过对象的get方法获取 使用缓存时需要通知DBTablesName.S_PERMISSION, 更新用户权限数据的缓存
	 * 
	 * @param record
	 *            角色权限关联关系实体
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_ROLE_PERMISSION })
	Integer save(RolePermission record);

	/**
	 * 根据角色ID加载角色权限关联关系列表
	 * 
	 * @param roleId
	 *            角色ID
	 * @return 关联关系列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE_PERMISSION })
	List<RolePermission> listByRoleId(Integer roleId);

	/**
	 * 根据权限ID加载角色权限关联关系列表
	 * 
	 * @param permissionId
	 *            权限ID
	 * @return 关联关系列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE_PERMISSION })
	List<RolePermission> listByPermissionId(Integer permissionId);

	/**
	 * 根据不同条件加载角色权限关联关系列表
	 * 
	 * @param roleId
	 *            角色ID
	 * @param permission
	 *            权限实体
	 * @return 关联关系列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_ROLE_PERMISSION,
			DBTablesName.System.S_PERMISSION })
	List<RolePermission> listRolePermissions(@Param("roleId") Integer roleId, @Param("permission") Permission permission);

}