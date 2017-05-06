package com.yilidi.o2o.controller.operation.system;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.system.service.IPermissionService;
import com.yilidi.o2o.system.service.IRolePermissionService;
import com.yilidi.o2o.system.service.IRoleService;
import com.yilidi.o2o.system.service.IUserRoleService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.RolePermissionDto;
import com.yilidi.o2o.user.service.ILoginLogService;

/**
 * 
 * @Description:TODO(角色权限Controller)
 * @author: chenlian
 * @date: 2015年11月5日 下午8:55:34
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class RolePermissionController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IPermissionService permissionService;

	@Autowired
	private IRoleService roleService;

	@Autowired
	private IRolePermissionService rolePermissionService;

	@Autowired
	private IUserRoleService userRoleService;

	@Autowired
	private ILoginLogService loginLogService;

	/**
	 * 
	 * @Description TODO(获取角色的所有权限菜单列表)
	 * @param roleId
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{roleId}/getAllRolePermissions")
	@ResponseBody
	public MsgBean getAllRolePermissions(@PathVariable("roleId") Integer roleId) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<RolePermissionDto> rolePermissionDtoList = rolePermissionService.listRolePermissions(roleId, permissionDto);
			return super.encapsulateMsgBean(rolePermissionDtoList, MsgBean.MsgCode.SUCCESS, "获取角色的所有权限菜单列表成功");
		} catch (Exception e) {
			logger.error("获取角色的所有权限菜单列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取角色的功能权限列表)
	 * @param roleId
	 * @param permissionLevel
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{roleId}-{permissionLevel}/getRoleFunctionPermissions")
	@ResponseBody
	public MsgBean getRoleFunctionPermissions(@PathVariable("roleId") Integer roleId,
			@PathVariable("permissionLevel") String permissionLevel) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionLevel(permissionLevel);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<RolePermissionDto> rolePermissionDtoList = rolePermissionService.listRolePermissions(roleId, permissionDto);
			return super.encapsulateMsgBean(rolePermissionDtoList, MsgBean.MsgCode.SUCCESS, "获取角色的功能权限列表成功");
		} catch (Exception e) {
			logger.error("获取角色的功能权限列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(角色功能分配)
	 * @param roleId
	 * @param strPermissionIds
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{roleId}-{strPermissionIds}/createRolePermissions")
	@ResponseBody
	public MsgBean createRolePermissions(@PathVariable("roleId") Integer roleId,
			@PathVariable("strPermissionIds") String strPermissionIds) {
		try {
			if (null != strPermissionIds) {
				String[] sPermissionIds = strPermissionIds.split(",");
				Integer[] permissionIds = new Integer[sPermissionIds.length];
				Integer lastPermissionId = null;
				String supperPermissionIds = null;
				for (int i = 0; i < sPermissionIds.length; i++) {
					permissionIds[i] = Integer.parseInt(sPermissionIds[i]);
					PermissionDto permissionDto = permissionService.loadPermissionById(permissionIds[i]);
					if (null != permissionDto
							&& permissionDto.getPermissionLevel().equals(
									SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU)) {
						Integer nowPermissionId = permissionDto.getParentId();
						if (i == 0) {
							supperPermissionIds = nowPermissionId.toString();
							lastPermissionId = nowPermissionId;
						} else if (nowPermissionId.intValue() != lastPermissionId.intValue()) {
							lastPermissionId = nowPermissionId;
							supperPermissionIds = supperPermissionIds + "," + nowPermissionId.toString();
						}
					}
				}
				String[] sPermissionIdss = (strPermissionIds + "," + supperPermissionIds).split(",");
				Integer[] permissionIdss = new Integer[sPermissionIdss.length];
				for (int i = 0; i < sPermissionIdss.length; i++) {
					permissionIdss[i] = Integer.parseInt(sPermissionIdss[i]);
				}
				rolePermissionService.saveRolePermissions(roleId, permissionIdss, super.getUserId(), new Date());
				return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "角色功能分配成功");
			} else {
				return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, "分配的权限ID字符串参数不能为空");
			}
		} catch (Exception e) {
			logger.error("角色功能分配失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}
