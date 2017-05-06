package com.yilidi.o2o.system.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.UserRoleDto;

/**
 * 
 * @Description:TODO(用户与角色关联关系Service服务接口类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:22:01
 * 
 */
public interface IUserRoleService {

	/**
	 * 
	 * @Description TODO(获取用户角色列表)
	 * @param userId
	 * @return List<UserRoleDto>
	 * @throws SystemServiceException
	 */
	public List<UserRoleDto> listUserRoles(Integer userId) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据角色ID获取绑定该角色的用户ID列表)
	 * @param roleId
	 * @return List<Integer>
	 * @throws SystemServiceException
	 */
	public List<Integer> listUserIdsByRoleId(Integer roleId) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(创建用户与角色的关联关系)
	 * @param userId
	 * @param roleIdss
	 * @param createUserId
	 * @param createTime
	 * @throws SystemServiceException
	 */
	public void saveUserRoles(Integer userId, Integer[] roleIdss, Integer createUserId, Date createTime)
			throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(删除用户与角色的关联关系)
	 * @param userId
	 * @param operateUserId
	 * @param operateTime
	 * @throws SystemServiceException
	 */
	public void deleteUserRoles(Integer userId, Integer operateUserId, Date operateTime) throws SystemServiceException;

}
