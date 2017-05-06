package com.yilidi.o2o.system.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.RolePermissionDto;

/**
 * 
 * @Description:TODO(角色与权限关联关系Service服务接口类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:19:56
 * 
 */
public interface IRolePermissionService {

	/**
	 * 
	 * @Description TODO(获取角色权限列表)
	 * @param roleId
	 * @param permissionDto
	 * @return List<RolePermissionDto>
	 * @throws SystemServiceException
	 */
	public List<RolePermissionDto> listRolePermissions(Integer roleId, PermissionDto permissionDto)
			throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(创建角色与权限的关联关系)
	 * @param roleId
	 * @param permissionIdss
	 * @param createUserId
	 * @param createTime
	 * @throws SystemServiceException
	 */
	public void saveRolePermissions(Integer roleId, Integer[] permissionIdss, Integer createUserId, Date createTime)
			throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(删除角色与权限的关联关系)
	 * @param roleId
	 * @param operateUserId
	 * @param operateTime
	 * @throws SystemServiceException
	 */
	public void deleteRolePermissions(Integer roleId, Integer operateUserId, Date operateTime) throws SystemServiceException;

}
