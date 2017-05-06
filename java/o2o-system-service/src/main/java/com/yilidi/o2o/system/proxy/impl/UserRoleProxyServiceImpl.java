package com.yilidi.o2o.system.proxy.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.RoleMapper;
import com.yilidi.o2o.system.dao.UserRoleHistoryMapper;
import com.yilidi.o2o.system.dao.UserRoleMapper;
import com.yilidi.o2o.system.model.UserRole;
import com.yilidi.o2o.system.model.UserRoleHistory;
import com.yilidi.o2o.system.proxy.IUserRoleProxyService;

/**
 * 用户与角色关联关系Service服务代理接口实现类
 * 
 * @author: heyong
 * @date: 2015年12月11日 上午11:04:54
 * 
 */
@Service("userRoleProxyService")
public class UserRoleProxyServiceImpl extends BaseService implements IUserRoleProxyService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;

	@Autowired
	private UserRoleHistoryMapper userRoleHistoryMapper;

	@Override
	public void saveUserRoles(Integer userId, Integer[] roleIds, Integer createUserId, Date createTime)
			throws SystemServiceException {
		try {
			this.deleteUserRoles(userId, createUserId, createTime);
			if (!ObjectUtils.isNullOrEmpty(roleIds)) {
				for (Integer roleId : roleIds) {
					UserRole userRole = new UserRole();
					userRole.setUserId(userId);
					userRole.setRoleId(roleId);
					userRole.setCreateUserId(createUserId);
					userRole.setCreateTime(createTime);
					this.userRoleMapper.save(userRole);
				}
				UserRoleHistory userRoleHistory = new UserRoleHistory();
				userRoleHistory.setUserId(userId);
				String strRoleIds = "";
				for (int i = 0; i < roleIds.length; i++) {
					if (i == roleIds.length - 1) {
						strRoleIds += roleIds[i];
					} else {
						strRoleIds += roleIds[i] + ",";
					}
				}
				userRoleHistory.setRoleIds(strRoleIds);
				userRoleHistory.setOperateUserId(createUserId);
				userRoleHistory.setOperateTime(createTime);
				userRoleHistory.setOperateType(SystemContext.SystemDomain.USERROLEOPERTYPE_CREATE);
				this.userRoleHistoryMapper.save(userRoleHistory);
			}
		} catch (Exception e) {
			String msg = "创建用户与角色的关联关系出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public void deleteUserRoles(Integer userId, Integer operateUserId, Date operateTime) throws SystemServiceException {
		try {
			if (null != userId) {
				List<UserRole> userRoleList = this.userRoleMapper.listByUserId(userId);
				if (!ObjectUtils.isNullOrEmpty(userRoleList)) {
					String strRoleIds = "";
					for (int i = 0; i < userRoleList.size(); i++) {
						if (i == userRoleList.size() - 1) {
							strRoleIds += userRoleList.get(i).getRoleId();
						} else {
							strRoleIds += userRoleList.get(i).getRoleId() + ",";
						}
					}
					this.userRoleMapper.deleteByUserId(userId);
					UserRoleHistory userRoleHistory = new UserRoleHistory();
					userRoleHistory.setUserId(userId);
					userRoleHistory.setRoleIds(strRoleIds);
					userRoleHistory.setOperateUserId(operateUserId);
					userRoleHistory.setOperateTime(operateTime);
					userRoleHistory.setOperateType(SystemContext.SystemDomain.USERROLEOPERTYPE_DELETE);
					this.userRoleHistoryMapper.save(userRoleHistory);
				}
			}
		} catch (Exception e) {
			String msg = "删除用户与角色的关联关系出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}
}
