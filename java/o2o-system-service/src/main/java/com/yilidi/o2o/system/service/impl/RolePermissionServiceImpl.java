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
import com.yilidi.o2o.system.dao.RolePermissionHistoryMapper;
import com.yilidi.o2o.system.dao.RolePermissionMapper;
import com.yilidi.o2o.system.model.Permission;
import com.yilidi.o2o.system.model.RolePermission;
import com.yilidi.o2o.system.model.RolePermissionHistory;
import com.yilidi.o2o.system.service.IRolePermissionService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.RolePermissionDto;

/**
 * 
 * @Description:TODO(角色与权限关联关系Service服务接口实现类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:42:20
 * 
 */
@Service("rolePermissionService")
public class RolePermissionServiceImpl extends BaseService implements IRolePermissionService {

	@Autowired
	private RolePermissionMapper rolePermissionMapper;

	@Autowired
	private RolePermissionHistoryMapper rolePermissionHistoryMapper;

	@Override
	public List<RolePermissionDto> listRolePermissions(Integer roleId, PermissionDto permissionDto)
			throws SystemServiceException {
		try {
			Permission permission = new Permission();
			ObjectUtils.fastCopy(permissionDto, permission);
			List<RolePermission> rolePermissionList = this.rolePermissionMapper.listRolePermissions(roleId, permission);
			List<RolePermissionDto> rolePermissionDtoList = new ArrayList<RolePermissionDto>();
			if (!ObjectUtils.isNullOrEmpty(rolePermissionList)) {
				for (RolePermission rolePermission : rolePermissionList) {
					RolePermissionDto rolePermissionDto = new RolePermissionDto();
					ObjectUtils.fastCopy(rolePermission, rolePermissionDto);
					rolePermissionDtoList.add(rolePermissionDto);
				}
			}
			return rolePermissionDtoList;
		} catch (Exception e) {
			String msg = "查询角色权限列表出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public void saveRolePermissions(Integer roleId, Integer[] permissionIdss, Integer createUserId, Date createTime)
			throws SystemServiceException {
		try {
			this.deleteRolePermissions(roleId, createUserId, createTime);
			if (!ObjectUtils.isNullOrEmpty(permissionIdss)) {
				for (Integer permissionId : permissionIdss) {
					RolePermission rolePermission = new RolePermission();
					rolePermission.setRoleId(roleId);
					rolePermission.setPermissionId(permissionId);
					rolePermission.setCreateUserId(createUserId);
					rolePermission.setCreateTime(createTime);
					this.rolePermissionMapper.save(rolePermission);
				}
				RolePermissionHistory rolePermissionHistory = new RolePermissionHistory();
				rolePermissionHistory.setRoleId(roleId);
				String strPermissionIds = "";
				for (int i = 0; i < permissionIdss.length; i++) {
					if (i == permissionIdss.length - 1) {
						strPermissionIds += permissionIdss[i];
					} else {
						strPermissionIds += permissionIdss[i] + ",";
					}
				}
				rolePermissionHistory.setPermissionIds(strPermissionIds);
				rolePermissionHistory.setOperateUserId(createUserId);
				rolePermissionHistory.setOperateTime(createTime);
				rolePermissionHistory.setOperateType(SystemContext.SystemDomain.ROLEPERMISSIONOPERTYPE_CREATE);
				this.rolePermissionHistoryMapper.save(rolePermissionHistory);
			}
		} catch (Exception e) {
			String msg = "创建角色与权限的关联关系出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public void deleteRolePermissions(Integer roleId, Integer operateUserId, Date operateTime) throws SystemServiceException {
		try {
			if (null != roleId) {
				List<RolePermission> rolePermissionList = this.rolePermissionMapper.listByRoleId(roleId);
				if (!ObjectUtils.isNullOrEmpty(rolePermissionList)) {
					String strPermissionIds = "";
					for (int i = 0; i < rolePermissionList.size(); i++) {
						if (i == rolePermissionList.size() - 1) {
							strPermissionIds += rolePermissionList.get(i).getPermissionId();
						} else {
							strPermissionIds += rolePermissionList.get(i).getPermissionId() + ",";
						}
					}
					this.rolePermissionMapper.deleteByRoleId(roleId);
					RolePermissionHistory rolePermissionHistory = new RolePermissionHistory();
					rolePermissionHistory.setRoleId(roleId);
					rolePermissionHistory.setPermissionIds(strPermissionIds);
					rolePermissionHistory.setOperateUserId(operateUserId);
					rolePermissionHistory.setOperateTime(operateTime);
					rolePermissionHistory.setOperateType(SystemContext.SystemDomain.ROLEPERMISSIONOPERTYPE_DELETE);
					this.rolePermissionHistoryMapper.save(rolePermissionHistory);
				}
			}
		} catch (Exception e) {
			String msg = "删除角色与权限的关联关系出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}
}
