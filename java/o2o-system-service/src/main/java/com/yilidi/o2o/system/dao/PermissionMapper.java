package com.yilidi.o2o.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.Permission;
import com.yilidi.o2o.system.service.dto.query.PermissionQuery;

/**
 * 功能描述：权限资源DAO接口，实在对权限资源的增删改查 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface PermissionMapper {

	/**
	 * 保存权限资源
	 * 
	 * @param permission
	 *            保存对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PERMISSION })
	Integer save(Permission permission);

	/**
	 * 根据主键ID删除权限
	 * 
	 * @param id
	 *            权限主键Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PERMISSION })
	Integer deleteById(Integer id);

	/**
	 * 根据父ID删除权限
	 * 
	 * @param parentId
	 *            父级ID
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PERMISSION })
	Integer deleteByParentId(Integer parentId);

	/**
	 * 更新数据（如果字段值为null，则该字段不更新， 推荐使用该方法进行更新）
	 * 
	 * @param permission
	 *            对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PERMISSION })
	Integer updateByIdSelective(Permission permission);

	/**
	 * 更新
	 * 
	 * @param permission
	 *            对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_PERMISSION })
	Integer updateById(Permission permission);

	/**
	 * 根据ID加载对象
	 * 
	 * @param id
	 *            主键Id
	 * @return 对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION })
	Permission loadById(Integer id);

	/**
	 * 根据权限编码加载对象
	 * 
	 * @param permissionCode
	 *            权限编码
	 * @return 对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION })
	Permission loadByPermissionCode(String permissionCode);

	/**
	 * 根据不同条件，获取用户的权限列表
	 * 
	 * @param permission
	 *            对象
	 * @return 权限对象列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION })
	List<Permission> listPermissions(Permission permission);

	/**
	 * 根据父ID获取权限列表
	 * 
	 * @param permission
	 *            对象
	 * @return 权限对象列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION })
	List<Permission> listByParentId(Integer parentId);

	/**
	 * 获取用户的权限列表
	 * 
	 * @param customerType
	 *            用户类型
	 * @param permissionLevel
	 *            权限级别
	 * @param permissionStatus
	 *            权限状态
	 * @param userId
	 *            用户Id
	 * @param parentId
	 *            父权限Id
	 * @return 权限对象列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION, DBTablesName.System.S_ROLE,
			DBTablesName.System.S_ROLE_PERMISSION, DBTablesName.System.S_USER_ROLE })
	List<Permission> listUserPermissions(@Param("customerType") String customerType,
			@Param("permissionLevel") String permissionLevel, @Param("permissionStatus") String permissionStatus,
			@Param("userId") Integer userId, @Param("parentId") Integer parentId);

	/**
	 * 根据不同条件，分页获取用户的权限信息
	 * 
	 * @param permissionQuery
	 *            权限查询对象
	 * @return 用户的权限分页信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_PERMISSION })
	Page<Permission> findPermissions(PermissionQuery permissionQuery);

}