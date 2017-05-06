package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.query.PermissionQuery;

/**
 * 
 * @Description:TODO(权限Service服务接口类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:17:44
 * 
 */
public interface IPermissionService {

	/**
	 * 
	 * @Description TODO(保存权限)
	 * @param permissionDto
	 * @throws SystemServiceException
	 */
	public void save(PermissionDto permissionDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据不同条件获取用户的权限列表)
	 * @param permissionDto
	 * @return List<PermissionDto>
	 * @throws SystemServiceException
	 */
	public List<PermissionDto> listPermissions(PermissionDto permissionDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(获取用户拥有的权限列表)
	 * @param customerType
	 * @param permissionLevel
	 * @param permissionStatus
	 * @param userId
	 * @param parentId
	 * @return List<PermissionDto>
	 * @throws SystemServiceException
	 */
	public List<PermissionDto> listUserPermissions(String customerType, String permissionLevel, String permissionStatus,
			Integer userId, Integer parentId) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据父ID获取权限列表)
	 * @param parentId
	 * @return
	 * @throws SystemServiceException
	 */
	public List<PermissionDto> listByParentId(Integer parentId) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(分页获取用户的权限信息)
	 * @param permissionQuery
	 * @return YiLiDiPage
	 * @throws SystemServiceException
	 */
	public YiLiDiPage<PermissionDto> findPermissions(PermissionQuery permissionQuery) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据ID获取权限信息)
	 * @param id
	 * @return PermissionDto
	 * @throws SystemServiceException
	 */
	public PermissionDto loadPermissionById(Integer id) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据权限编码获取权限信息)
	 * @param permissionCode
	 * @return PermissionDto
	 * @throws SystemServiceException
	 */
	public PermissionDto loadPermissionByPermissionCode(String permissionCode) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改权限)
	 * @param permissionDto
	 * @throws SystemServiceException
	 */
	public void update(PermissionDto permissionDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改权限状态)
	 * @param permissionDto
	 * @throws SystemServiceException
	 */
	public void updateStatus(PermissionDto permissionDto) throws SystemServiceException;

}
