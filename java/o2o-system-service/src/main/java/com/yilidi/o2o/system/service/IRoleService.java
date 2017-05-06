package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.RoleDto;
import com.yilidi.o2o.system.service.dto.query.RoleQuery;

/**
 * 
 * @Description:TODO(角色Service服务接口类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:17:04
 * 
 */
public interface IRoleService {

	/**
	 * 
	 * @Description TODO(创建角色)
	 * @param roleDto
	 * @throws SystemServiceException
	 */
	public void save(RoleDto roleDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(获取特定用户类型的角色信息列表)
	 * @param customerType
	 * @return List<RoleDto>
	 * @throws SystemServiceException
	 */
	public List<RoleDto> listRolesForSpecificCustomerType(String customerType) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据不同条件加载角色信息列表)
	 * @param roleDto
	 * @return List<RoleDto>
	 * @throws SystemServiceException
	 */
	public List<RoleDto> listRoles(RoleDto roleDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(分页获取角色列表信息)
	 * @param roleQuery
	 * @return YiLiDiPage
	 * @throws SystemServiceException
	 */
	public YiLiDiPage<RoleDto> findRoles(RoleQuery roleQuery) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据角色ID获取角色信息)
	 * @param id
	 * @return RoleDto
	 * @throws SystemServiceException
	 */
	public RoleDto loadRoleById(Integer id) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改角色)
	 * @param roleDto
	 * @throws SystemServiceException
	 */
	public void update(RoleDto roleDto) throws SystemServiceException;

	/**
	 * 根据角色名称和客户类型获取角色信息
	 * 
	 * @param roleName 角色名称
	 * @param customerType 客户类型
	 * @return RoleDto
	 * @throws SystemServiceException
	 * 			系统域服务异常
	 */
	public RoleDto loadRoleByNameAndCustomerType(String roleName, String customerType) throws SystemServiceException;

}
