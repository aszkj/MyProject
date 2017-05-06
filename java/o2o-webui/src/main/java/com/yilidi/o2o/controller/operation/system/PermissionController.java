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
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.service.IPermissionService;
import com.yilidi.o2o.system.service.IRolePermissionService;
import com.yilidi.o2o.system.service.IRoleService;
import com.yilidi.o2o.system.service.IUserRoleService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.query.PermissionQuery;
import com.yilidi.o2o.user.service.ILoginLogService;

/**
 * 
 * @Description:TODO(权限Controller)
 * @author: chenlian
 * @date: 2015年11月5日 下午8:55:34
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class PermissionController extends OperationBaseController {

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
	 * @Description TODO(获取用户的菜单权限)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/getUserPermissionMenus")
	@ResponseBody
	public MsgBean getUserPermissionMenus() {
		try {
			YiLiDiSession session = YiLiDiSessionHolder.getSession();
			return super.encapsulateMsgBean(session.getAttribute("menus"), MsgBean.MsgCode.SUCCESS, "获取用户的菜单权限成功");
		} catch (Exception e) {
			logger.error("获取用户的菜单权限失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取用户的功能权限)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/getUserPermissionFunctionCodes")
	@ResponseBody
	public MsgBean getUserPermissionFunctionCodes() {
		try {
			YiLiDiSession session = YiLiDiSessionHolder.getSession();
			return super.encapsulateMsgBean(session.getAttribute("functionCodes"), MsgBean.MsgCode.SUCCESS, "获取用户的功能权限成功");
		} catch (Exception e) {
			logger.error("获取用户的功能权限失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(查询权限菜单)
	 * @param permissionQuery
	 * @return MsgBean
	 */
	@RequestMapping(value = "/searchPermissionMenus")
	@ResponseBody
	public MsgBean searchPermissionMenus(@RequestBody PermissionQuery permissionQuery) {
		try {
			YiLiDiPage<PermissionDto> yiLiDiPage = permissionService.findPermissions(permissionQuery);
			logger.info("========= yiLiDiPage : " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
			return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "查询权限菜单成功");
		} catch (Exception e) {
			logger.error("查询权限菜单失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(根据ID获取菜单权限信息)
	 * @param id
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}/searchPermissionMenu")
	@ResponseBody
	public MsgBean searchPermissionMenu(@PathVariable Integer id) {
		try {
			PermissionDto permissionDto = permissionService.loadPermissionById(id);
			return super.encapsulateMsgBean(permissionDto, MsgBean.MsgCode.SUCCESS, "获取菜单权限信息成功");
		} catch (Exception e) {
			logger.error("获取菜单权限信息失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(根据权限编码验证该编码是否存在)
	 * @param id
	 * @param permissionCode
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{permissionCode}/checkPermissionCodeIsExist")
	@ResponseBody
	public MsgBean checkPermissionCodeIsExist(@PathVariable("id") Integer id,
			@PathVariable("permissionCode") String permissionCode) {
		try {
			PermissionDto permissionDto = permissionService.loadPermissionByPermissionCode(permissionCode);
			if (null == permissionDto) {
				return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "权限编码不存在");
			} else {
				if (null == id) {
					return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "权限编码已存在");
				} else {
					PermissionDto pDto = permissionService.loadPermissionById(id);
					if (permissionCode.equals(pDto.getPermissionCode())) {
						return super.encapsulateMsgBean(true, MsgBean.MsgCode.SUCCESS, "权限编码不存在");
					} else {
						return super.encapsulateMsgBean(false, MsgBean.MsgCode.SUCCESS, "权限编码已存在");
					}
				}
			}
		} catch (Exception e) {
			logger.error("对该编码是否存在的验证失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(创建一级菜单)
	 * @param permissionDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/createFirstMenu")
	@ResponseBody
	public MsgBean createFirstMenu(@RequestBody PermissionDto permissionDto) {
		try {
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("一级菜单", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(customerType, permissionName, permissionCode);
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			permissionDto.setParentId(0);
			permissionDto.setParentName("根权限");
			permissionDto.setCreateUserId(super.getUserId());
			permissionDto.setCreateTime(new Date());
			permissionService.save(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建一级菜单成功");
		} catch (Exception e) {
			logger.error("创建一级菜单失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(创建二级菜单)
	 * @param permissionDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/createSecondMenu")
	@ResponseBody
	public MsgBean createSecondMenu(@RequestBody PermissionDto permissionDto) {
		try {
			Param parentId = new Param.Builder("上级菜单", Param.ParamType.INTEGER_TYPE.getType(), permissionDto.getParentId(),
					false).build();
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("菜单名称", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionUrl = new Param.Builder("菜单URL", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionUrl(), false).maxLength(128).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(parentId, customerType, permissionName, permissionUrl, permissionCode);
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			permissionDto.setCreateUserId(super.getUserId());
			permissionDto.setCreateTime(new Date());
			permissionService.save(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建二级菜单成功");
		} catch (Exception e) {
			logger.error("创建二级菜单失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(创建功能)
	 * @param permissionDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/createFunction")
	@ResponseBody
	public MsgBean createFunction(@RequestBody PermissionDto permissionDto) {
		try {
			Param parentId = new Param.Builder("上级菜单", Param.ParamType.INTEGER_TYPE.getType(), permissionDto.getParentId(),
					false).build();
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("功能名称", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(parentId, customerType, permissionName, permissionCode);
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_FUNCTION);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_FUNC);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			permissionDto.setCreateUserId(super.getUserId());
			permissionDto.setCreateTime(new Date());
			permissionService.save(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "创建功能成功");
		} catch (Exception e) {
			logger.error("创建功能失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(修改一级菜单)
	 * @param permissionDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateFirstMenu")
	@ResponseBody
	public MsgBean updateFirstMenu(@RequestBody PermissionDto permissionDto) {
		try {
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("一级菜单", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(customerType, permissionName, permissionCode);
			Integer permissionId = permissionDto.getId();
			if (null == permissionId) {
				throw new IllegalArgumentException("无法获取需修改的菜单ID");
			}
			permissionDto.setModifyUser(super.getUserId());
			permissionDto.setModifyTime(new Date());
			permissionService.update(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改一级菜单成功");
		} catch (Exception e) {
			logger.error("修改一级菜单失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(修改二级菜单)
	 * @param permissionDto
	 * @return MsgBean
	 */
	@RequestMapping(value = "/updateSecondMenu")
	@ResponseBody
	public MsgBean updateSecondMenu(@RequestBody PermissionDto permissionDto) {
		try {
			Param parentId = new Param.Builder("上级菜单", Param.ParamType.INTEGER_TYPE.getType(), permissionDto.getParentId(),
					false).build();
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("菜单名称", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionUrl = new Param.Builder("菜单URL", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionUrl(), false).maxLength(128).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(parentId, customerType, permissionName, permissionUrl, permissionCode);
			Integer permissionId = permissionDto.getId();
			if (null == permissionId) {
				throw new IllegalArgumentException("无法获取需修改的菜单ID");
			}
			permissionDto.setModifyUser(super.getUserId());
			permissionDto.setModifyTime(new Date());
			permissionService.update(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改二级菜单成功");
		} catch (Exception e) {
			logger.error("修改二级菜单失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(修改功能)
	 * @param permissionDto
	 * @return
	 */
	@RequestMapping(value = "/updateFunction")
	@ResponseBody
	public MsgBean updateFunction(@RequestBody PermissionDto permissionDto) {
		try {
			Param parentId = new Param.Builder("上级菜单", Param.ParamType.INTEGER_TYPE.getType(), permissionDto.getParentId(),
					false).build();
			Param customerType = new Param.Builder("用户类型", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getCustomerType(), false).build();
			Param permissionName = new Param.Builder("功能名称", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionName(), false).maxLength(64).build();
			Param permissionCode = new Param.Builder("权限编码", Param.ParamType.STR_NORMAL.getType(),
					permissionDto.getPermissionCode(), false).maxLength(64).build();
			super.validateParams(parentId, customerType, permissionName, permissionCode);
			Integer permissionId = permissionDto.getId();
			if (null == permissionId) {
				throw new IllegalArgumentException("无法获取需修改的菜单ID");
			}
			permissionDto.setModifyUser(super.getUserId());
			permissionDto.setModifyTime(new Date());
			permissionService.update(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改功能成功");
		} catch (Exception e) {
			logger.error("修改功能失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取一级菜单列表)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{customerType}/getFirstMenuList")
	@ResponseBody
	public MsgBean getFirstMenuList(@PathVariable("customerType") String customerType) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
			permissionDto.setCustomerType(customerType);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<PermissionDto> permissionDtoList = permissionService.listPermissions(permissionDto);
			return super.encapsulateMsgBean(permissionDtoList, MsgBean.MsgCode.SUCCESS, "获取一级菜单列表成功");
		} catch (Exception e) {
			logger.error("获取一级菜单列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取二级菜单列表)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{customerType}/getSecondMenuList")
	@ResponseBody
	public MsgBean getSecondMenuList(@PathVariable("customerType") String customerType) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
			permissionDto.setCustomerType(customerType);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<PermissionDto> permissionDtoList = permissionService.listPermissions(permissionDto);
			return super.encapsulateMsgBean(permissionDtoList, MsgBean.MsgCode.SUCCESS, "获取二级菜单列表成功");
		} catch (Exception e) {
			logger.error("获取二级菜单列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(获取功能列表)
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{customerType}/getFunctionList")
	@ResponseBody
	public MsgBean getFunctionList(@PathVariable("customerType") String customerType) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_FUNCTION);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_FUNC);
			permissionDto.setCustomerType(customerType);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<PermissionDto> permissionDtoList = permissionService.listPermissions(permissionDto);
			return super.encapsulateMsgBean(permissionDtoList, MsgBean.MsgCode.SUCCESS, "获取功能列表成功");
		} catch (Exception e) {
			logger.error("获取功能列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	/**
	 * 
	 * @Description TODO(修改权限状态)
	 * @param id
	 * @param permissionStatus
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{id}-{permissionStatus}/changeStatus")
	@ResponseBody
	public MsgBean changeStatus(@PathVariable("id") Integer id, @PathVariable("permissionStatus") String permissionStatus) {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setId(id);
			permissionDto.setPermissionStatus(permissionStatus);
			permissionDto.setModifyUser(super.getUserId());
			permissionDto.setModifyTime(new Date());
			permissionService.updateStatus(permissionDto);
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改权限状态成功");
		} catch (Exception e) {
			logger.error("修改权限状态失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

}
