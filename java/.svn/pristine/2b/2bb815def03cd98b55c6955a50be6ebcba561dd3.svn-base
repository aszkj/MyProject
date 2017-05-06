package com.yilidi.o2o.system.proxy;

import java.util.Date;

import com.yilidi.o2o.core.exception.SystemServiceException;

/**
 * 用户与角色关联关系Service服务接口类
 * 
 * @author: heyong
 * @date: 2015年12月11日 上午10:58:18
 * 
 */
public interface IUserRoleProxyService {

	/**
	 * 
	 * 创建用户与角色的关联关系
	 * 
	 * @param userId
	 *            用户ID
	 * @param roleIdss
	 *            角色ID
	 * @param createUserId
	 *            创建人ID
	 * @param createTime
	 *            创建时间
	 * @throws SystemServiceException
	 *             系统域异常服务
	 */
	public void saveUserRoles(Integer userId, Integer[] roleIdss, Integer createUserId, Date createTime)
			throws SystemServiceException;

	/**
	 * 
	 * 删除用户与角色的关联关系
	 * 
	 * @param userId
	 *            用户ID
	 * @param operateUserId
	 *            操作人ID
	 * @param operateTime
	 *            执行时间
	 * @throws SystemServiceException
	 *             系统域异常服务
	 */
	public void deleteUserRoles(Integer userId, Integer operateUserId, Date operateTime) throws SystemServiceException;
}
