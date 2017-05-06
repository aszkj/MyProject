package com.yilidi.o2o.controller.operation.system;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.IUserRoleService;
import com.yilidi.o2o.system.service.dto.UserRoleDto;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.RoleBindingUserInfoDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * 
 * @Description:TODO(用户角色Controller)
 * @author: chenlian
 * @date: 2015年11月5日 下午8:55:34
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class UserRoleController extends OperationBaseController {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IUserRoleService userRoleService;

	@Autowired
	private IUserService userService;

	/**
	 * 
	 * @Description TODO(获取用户的所有角色列表)
	 * @param userId
	 * @return MsgBean
	 */
	@RequestMapping(value = "/{userId}/getUserRoles")
	@ResponseBody
	public MsgBean getUserRoles(@PathVariable("userId") Integer userId) {
		try {
			List<UserRoleDto> userRoleDtoList = userRoleService.listUserRoles(userId);
			return super.encapsulateMsgBean(userRoleDtoList, MsgBean.MsgCode.SUCCESS, "获取用户的所有角色列表成功");
		} catch (Exception e) {
			logger.error("获取用户的所有角色列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/{roleId}/searchRoleUsers")
	@ResponseBody
	public MsgBean searchRoleUsers(@RequestBody UserQuery userQuery, @PathVariable("roleId") Integer roleId) {
		try {
			List<Integer> userIdList = userRoleService.listUserIdsByRoleId(roleId);
			if (!ObjectUtils.isNullOrEmpty(userIdList)) {
				YiLiDiPage<RoleBindingUserInfoDto> yiLiDiPage = userService.findRoleBindingUsers(userIdList, userQuery);
				return super.encapsulateMsgBean(yiLiDiPage, MsgBean.MsgCode.SUCCESS, "获取角色的所有绑定用户列表成功");
			}
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "获取角色的所有绑定用户列表成功");
		} catch (Exception e) {
			logger.error("获取角色的所有绑定用户列表失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	@RequestMapping(value = "/{userId}-{strRoleIds}/userRoleBinding")
	@ResponseBody
	public MsgBean userRoleBinding(@PathVariable("userId") Integer userId, @PathVariable("strRoleIds") String strRoleIds) {
		try {
			userRoleService.saveUserRoles(userId, getRoleIds(strRoleIds), super.getUserId(), new Date());
			return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "用户与角色绑定成功");
		} catch (Exception e) {
			logger.error("用户与角色绑定失败：" + e.getMessage(), e);
			return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
		}
	}

	private Integer[] getRoleIds(String strRoleIds) {
		if (!StringUtils.isEmpty(strRoleIds)) {
			String[] sRoleIds = strRoleIds.split("_");
			Integer[] roleIds = new Integer[sRoleIds.length];
			for (int i = 0; i < sRoleIds.length; i++) {
				roleIds[i] = Integer.parseInt(sRoleIds[i]);
			}
			return roleIds;
		} else {
			return null;
		}
	}

}
