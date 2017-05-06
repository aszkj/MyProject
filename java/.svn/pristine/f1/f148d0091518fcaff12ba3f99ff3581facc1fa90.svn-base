package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
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
import com.yilidi.o2o.system.model.Role;
import com.yilidi.o2o.system.model.UserRole;
import com.yilidi.o2o.system.model.UserRoleHistory;
import com.yilidi.o2o.system.service.IUserRoleService;
import com.yilidi.o2o.system.service.dto.UserRoleDto;

/**
 * 
 * @Description:TODO(用户与角色关联关系Service服务接口实现类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:44:21
 * 
 */
@Service("userRoleService")
public class UserRoleServiceImpl extends BaseService implements IUserRoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private UserRoleMapper userRoleMapper;

	@Autowired
	private UserRoleHistoryMapper userRoleHistoryMapper;

	@Override
	public List<UserRoleDto> listUserRoles(Integer userId) throws SystemServiceException {
		try {
			List<UserRole> userRoleList = this.userRoleMapper.listByUserId(userId);
			List<UserRoleDto> userRoleDtoList = new ArrayList<UserRoleDto>();
			if (!ObjectUtils.isNullOrEmpty(userRoleList)) {
				for (UserRole userRole : userRoleList) {
					UserRoleDto userRoleDto = new UserRoleDto();
					ObjectUtils.fastCopy(userRole, userRoleDto);
					Role role = this.roleMapper.loadById(userRole.getRoleId());
					if (null != role) {
						userRoleDto.setRoleName(role.getRoleName());
					}
					userRoleDtoList.add(userRoleDto);
				}
			}
			return userRoleDtoList;
		} catch (Exception e) {
			String msg = "获取用户角色列表出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public List<Integer> listUserIdsByRoleId(Integer roleId) throws SystemServiceException {
		try {
			List<UserRole> userRoleList = this.userRoleMapper.listByRoleId(roleId);
			List<Integer> userIdList = null;
			if (!ObjectUtils.isNullOrEmpty(userRoleList)) {
				userIdList = new ArrayList<Integer>();
				for (UserRole userRole : userRoleList) {
					userIdList.add(userRole.getUserId());
				}
			}
			return userIdList;
		} catch (Exception e) {
			String msg = "根据角色ID获取绑定该角色的用户ID列表出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

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
