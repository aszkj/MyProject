package com.yilidi.o2o.controller.operation.system;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.service.IRolePermissionService;
import com.yilidi.o2o.system.service.IRoleService;
import com.yilidi.o2o.system.service.IUserRoleService;
import com.yilidi.o2o.system.service.dto.RoleDto;
import com.yilidi.o2o.system.service.dto.query.RoleQuery;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 
 * @Description:TODO(角色Controller)
 * @author: chenlian
 * @date: 2015年11月7日 下午5:48:03
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class RoleController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IRoleService roleService;

	@Autowired
	private IRolePermissionService rolePermissionService;

	@Autowired
	private IUserRoleService userRoleService;

	@Autowired
	private IUserService userService;

	/**
	 * 
	 * @Description TODO(根据不同条件分页查询角色信息)
	 * @param roleQuery
	 * @return MsgBean
	 */
	@RequestMapping(value = "/searchRoles")
	@ResponseBody
	public MsgBean searchRoles(@RequestBody RoleQuery roleQuery) {
		try {
			YiLiDiPage<RoleDto> yiLiDiPage = roleService.findRoles(roleQuery);
			logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
			return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询角色成功");
		} catch (Exception e) {
			logger.error("查询角色失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(根据ID获取角色信息)
	 * @param id
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/searchRole")
	@ResponseBody
	public MsgBean searchRole(@PathVariable Integer id) {
		try {
			RoleDto roleDto = roleService.loadRoleById(id);
			return super.encapsulateMsgBean(roleDto, MsgBean.MsgCode.SUCCESS, "获取角色信息成功");
		} catch (Exception e) {
			logger.error("获取角色信息失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(创建角色)
	 * @param roleDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/createRole")
	@ResponseBody
	public MsgBean createRole(@RequestBody RoleDto roleDto) {
		try {
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(), roleDto.getCustomerType(),
					false).build();
			Param roleName = new Param.Builder("角色名称", Param.ParamType.STR_NORMAL.getType(), roleDto.getRoleName(), false)
					.maxLength(128).build();
			super.validateParams(customerType, roleName);
			UserDto userDto = userService.loadUserById(super.getUserId());
			roleDto.setCustomerId(userDto.getCustomerId());
			roleDto.setCreateUserId(super.getUserId());
			roleDto.setCreateTime(new Date());
			roleService.save(roleDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建角色成功");
		} catch (Exception e) {
			logger.error("创建角色失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(修改角色)
	 * @param roleDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateRole")
	@ResponseBody
	public MsgBean updateRole(@RequestBody RoleDto roleDto) {
		try {
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(), roleDto.getCustomerType(),
					false).build();
			Param roleName = new Param.Builder("角色名称", Param.ParamType.STR_NORMAL.getType(), roleDto.getRoleName(), false)
					.maxLength(128).build();
			super.validateParams(customerType, roleName);
			roleDto.setModifyUser(super.getUserId());
			roleDto.setModifyTime(new Date());
			roleService.update(roleDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改角色成功");
		} catch (Exception e) {
			logger.error("修改角色失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取特定用户类型的角色信息列表)
	 * @param customerType
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{customerType}/getRoleListForSpecificCustomerType")
	@ResponseBody
	public MsgBean getRoleListForSpecificCustomerType(@PathVariable("customerType") String customerType) {
		try {
			List<RoleDto> roleDtoList = roleService.listRolesForSpecificCustomerType(customerType);
			return super.encapsulateMsgBean(roleDtoList, MsgBean.MsgCode.SUCCESS, "获取特定用户类型的角色信息列表成功");
		} catch (Exception e) {
			logger.error("获取特定用户类型的角色信息列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}
