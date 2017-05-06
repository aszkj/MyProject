package com.yilidi.o2o.system.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.dao.RoleHistoryMapper;
import com.yilidi.o2o.system.dao.RoleMapper;
import com.yilidi.o2o.system.model.Role;
import com.yilidi.o2o.system.model.RoleHistory;
import com.yilidi.o2o.system.service.IRoleService;
import com.yilidi.o2o.system.service.dto.RoleDto;
import com.yilidi.o2o.system.service.dto.query.RoleQuery;

/**
 * 
 * @Description:TODO(角色Service服务接口实现类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:40:20
 * 
 */
@Service("roleService")
public class RoleServiceImpl extends BasicDataService implements IRoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Autowired
	private RoleHistoryMapper roleHistoryMapper;

	@Override
	public void save(RoleDto roleDto) throws SystemServiceException {
		try {
			Role role = new Role();
			ObjectUtils.fastCopy(roleDto, role);
			this.roleMapper.save(role);
			RoleHistory roleHistory = new RoleHistory();
			ObjectUtils.fastCopy(roleDto, roleHistory);
			roleHistory.setRoleId(role.getId());
			roleHistory.setOperateUserId(role.getCreateUserId());
			roleHistory.setOperateTime(role.getCreateTime());
			roleHistory.setOperateType(SystemContext.SystemDomain.ROLEOPERTYPE_CREATE);
			this.roleHistoryMapper.save(roleHistory);
		} catch (Exception e) {
			String msg = "创建角色信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public List<RoleDto> listRolesForSpecificCustomerType(String customerType) throws SystemServiceException {
		try {
			List<Role> roleList = this.roleMapper.listByCustomerType(customerType);
			List<RoleDto> roleDtoList = new ArrayList<RoleDto>();
			if (!ObjectUtils.isNullOrEmpty(roleList)) {
				for (Role model : roleList) {
					RoleDto dto = new RoleDto();
					ObjectUtils.fastCopy(model, dto);
					roleDtoList.add(dto);
				}
			}
			return roleDtoList;
		} catch (Exception e) {
			String msg = "获取特定用户类型的角色信息列表出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public List<RoleDto> listRoles(RoleDto roleDto) throws SystemServiceException {
		try {
			Role role = new Role();
			ObjectUtils.fastCopy(roleDto, role);
			List<Role> roleList = this.roleMapper.listRoles(role);
			List<RoleDto> roleDtoList = new ArrayList<RoleDto>();
			if (!ObjectUtils.isNullOrEmpty(roleList)) {
				for (Role model : roleList) {
					RoleDto dto = new RoleDto();
					ObjectUtils.fastCopy(model, dto);
					roleDtoList.add(dto);
				}
			}
			return roleDtoList;
		} catch (Exception e) {
			String msg = "获取角色列表出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public YiLiDiPage<RoleDto> findRoles(RoleQuery roleQuery) throws SystemServiceException {
		try {
			if (null == roleQuery.getStart() || roleQuery.getStart() <= 0) {
				roleQuery.setStart(1);
			}
			if (null == roleQuery.getPageSize() || roleQuery.getPageSize() <= 0) {
				roleQuery.setPageSize(CommonConstants.PAGE_SIZE);
			}
			PageHelper.startPage(roleQuery.getStart(), roleQuery.getPageSize());
			Page<Role> page = this.roleMapper.findRoles(roleQuery);
			Page<RoleDto> pageDto = new Page<RoleDto>(roleQuery.getStart(), roleQuery.getPageSize());
			ObjectUtils.fastCopy(page, pageDto);
			List<Role> roles = page.getResult();
			if (!ObjectUtils.isNullOrEmpty(roles)) {
				for (Role role : roles) {
					RoleDto roleDto = new RoleDto();
					ObjectUtils.fastCopy(role, roleDto);
					pageDto.add(roleDto);
				}
			}
			return YiLiDiPageUtils.encapsulatePageResult(pageDto);
		} catch (Exception e) {
			String msg = "分页获取角色列表信息出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public RoleDto loadRoleById(Integer id) throws SystemServiceException {
		try {
			Role role = this.roleMapper.loadById(id);
			RoleDto roleDto = null;
			if (null != role) {
				roleDto = new RoleDto();
				ObjectUtils.fastCopy(role, roleDto);
			}
			String customerTypeName = super.getSystemDictName(SystemContext.UserDomain.DictType.CUSTOMERTYPE.getValue(),
					roleDto.getCustomerType());
			roleDto.setCustomerTypeName(customerTypeName);
			return roleDto;
		} catch (Exception e) {
			String msg = "根据角色ID获取角色信息";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public void update(RoleDto roleDto) throws SystemServiceException {
		try {
			Integer roleId = roleDto.getId();
			if (null != roleId) {
				Role role = this.roleMapper.loadById(roleId);
				if (null != role) {
					role.setCustomerType(roleDto.getCustomerType());
					role.setRoleName(roleDto.getRoleName());
					role.setRoleDesc(roleDto.getRoleDesc());
					role.setModifyUser(roleDto.getModifyUser());
					role.setModifyTime(roleDto.getModifyTime());
					this.roleMapper.updateById(role);
					RoleHistory roleHistory = new RoleHistory();
					ObjectUtils.fastCopy(role, roleHistory);
					roleHistory.setRoleId(role.getId());
					roleHistory.setOperateUserId(role.getModifyUser());
					roleHistory.setOperateTime(role.getModifyTime());
					roleHistory.setOperateType(SystemContext.SystemDomain.ROLEOPERTYPE_MODIFY);
					this.roleHistoryMapper.save(roleHistory);
				}
			}
		} catch (Exception e) {
			String msg = "修改角色出现系统异常";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

	@Override
	public RoleDto loadRoleByNameAndCustomerType(String roleName, String customerType) throws SystemServiceException {
		try {
			Role role = this.roleMapper.loadRoleByNameAndCustomerType(roleName, customerType);
			RoleDto roleDto = null;
			if (null != role) {
				roleDto = new RoleDto();
				ObjectUtils.fastCopy(role, roleDto);
			}
			String customerTypeName = super.getSystemDictName(SystemContext.UserDomain.DictType.CUSTOMERTYPE.getValue(),
					roleDto.getCustomerType());
			roleDto.setCustomerTypeName(customerTypeName);
			return roleDto;
		} catch (Exception e) {
			String msg = "根据角色名称和客户类型获取角色信息";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		}
	}

}
