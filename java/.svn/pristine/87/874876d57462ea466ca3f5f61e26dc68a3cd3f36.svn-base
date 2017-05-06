package com.yilidi.o2o.controller.operation.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.service.IPermissionService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.user.service.ILoginLogService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.UserBaseDto;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 
 * @Description:TODO(登录Controller)
 * @author: chenlian
 * @date: 2015年11月2日 上午11:40:11
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class LoginOperationController extends OperationBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserService userService;

    @Autowired
    private ILoginLogService loginLogService;

    @Autowired
    private IPermissionService permissionService;

    /**
     * 
     * @Description TODO(用户登录)
     * @param request
     * @param userBaseDto
     * @return MsgBean
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    public MsgBean login(HttpServletRequest request, @RequestBody UserBaseDto useBaseDto) {
        try {
            UserDto userDto = userService.loginValidate(useBaseDto.getUserName(),
                    SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR, SystemContext.UserDomain.LOGINTYPE_PASSWORD,
                    useBaseDto.getPassword());
            YiLiDiSession session = YiLiDiSessionHolder.getSession();
            LoginLogDto llDto = loginLogService.getLoginLogBySessionId(session.getId());
            if (null == llDto) {
                // 记录登录日志
                LoginLogDto loginLogDto = new LoginLogDto();
                loginLogDto.setSessionId(session.getId());
                loginLogDto.setUserId(userDto.getId());
                loginLogDto.setUserName(userDto.getUserName());
                loginLogDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
                loginLogDto.setLoginTime(new Date());
                // 客户端真实IP，之所以能获取到该真实IP，是因为在Nginx里配置了“proxy_set_header X-Real-IP $remote_addr”。
                String realIP = request.getHeader("X-Real-IP");
                loginLogDto.setLoginIP(realIP);
                loginLogDto.setLoginChannelCode(SystemContext.UserDomain.CHANNELTYPE_WEB);
                loginLogService.saveLoginLog(loginLogDto);
            }
            session.setAttribute("userId_operation", userDto.getId());
            session.setAttribute("userName_operation", userDto.getUserName());
            session.setAttribute("masterUserId_operation", userDto.getMasterUserId());
            // 获取用户的菜单权限
            List<PermissionDto> menus = getUserPermissionMenus();
            // 获取用户的功能权限
            List<String> functionCodes = getUserPermissionFunctionCodes();
            session.setAttribute("menus", menus);
            session.setAttribute("functionCodes", functionCodes);
            String message = "用户登录成功";
            logger.info("============== : " + message);
            return super.encapsulateMsgBean(userDto, MsgBean.MsgCode.SUCCESS, message);
        } catch (Exception e) {
            logger.error("用户登录失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping(value = "/logout")
    @ResponseBody
    public MsgBean logout() {
        try {
            YiLiDiSession session = YiLiDiSessionHolder.getSession();
            LoginLogDto llDto = loginLogService.getLoginLogBySessionId(session.getId());
            if (null != llDto) {
                // 更新登录日志
                loginLogService.updateLogoutTimeBySessionId(llDto.getSessionId());
            }
            session.invalidate();
            String message = "用户登出成功";
            logger.info("============== : " + message);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, message);
        } catch (Exception e) {
            logger.error("用户登出失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * @Description TODO(获取用户的菜单权限)
     * @return List<PermissionDto>
     */
    private List<PermissionDto> getUserPermissionMenus() {
        try {
            String customerType = SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR;
            String firstPermissionLevel = SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU;
            String secondPermissionLevel = SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU;
            String permissionStatus = SystemContext.SystemDomain.PERMISSIONSTATUS_ON;
            List<PermissionDto> permissionDtoList = new ArrayList<PermissionDto>();
            List<PermissionDto> firstPermissionDtoList = permissionService.listUserPermissions(customerType,
                    firstPermissionLevel, permissionStatus, super.getUserId(), null);
            if (!ObjectUtils.isNullOrEmpty(firstPermissionDtoList)) {
                for (PermissionDto firstPermissionDto : firstPermissionDtoList) {
                    Boolean flag = true;
                    for (PermissionDto dto : permissionDtoList) {
                        if (dto.getId().intValue() == firstPermissionDto.getId().intValue()) {
                            flag = false;
                        }
                    }
                    if (flag) {
                        permissionDtoList.add(firstPermissionDto);
                    }
                    List<PermissionDto> list = new ArrayList<PermissionDto>();
                    List<PermissionDto> secondPermissionDtoList = permissionService.listUserPermissions(customerType,
                            secondPermissionLevel, permissionStatus, super.getUserId(), firstPermissionDto.getId());
                    if (!ObjectUtils.isNullOrEmpty(secondPermissionDtoList)) {
                        for (PermissionDto secondPermissionDto : secondPermissionDtoList) {
                            if (!list.contains(secondPermissionDto)) {
                                list.add(secondPermissionDto);
                            }
                        }
                    }
                    firstPermissionDto.setNextLevelPermissionList(list);
                }
            }
            return permissionDtoList;
        } catch (SystemServiceException e) {
            throw new IllegalStateException(e.getMessage());
        }
    }

    /**
     * 
     * @Description TODO(获取用户的功能权限)
     * @return List<String>
     */
    private List<String> getUserPermissionFunctionCodes() {
        try {
            String customerType = SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR;
            String functionLevel = SystemContext.SystemDomain.PERMISSIONLEVEL_FUNCTION;
            String permissionStatus = SystemContext.SystemDomain.PERMISSIONSTATUS_ON;
            List<String> functionCodes = new ArrayList<String>();
            List<PermissionDto> functionDtoList = permissionService.listUserPermissions(customerType, functionLevel,
                    permissionStatus, super.getUserId(), null);
            if (!ObjectUtils.isNullOrEmpty(functionDtoList)) {
                for (PermissionDto function : functionDtoList) {
                    functionCodes.add(function.getPermissionCode());
                }
            }
            return functionCodes;
        } catch (SystemServiceException e) {
            throw new IllegalStateException(e.getMessage());
        }
    }

    /**
     * 
     * @Description TODO(获取用户登录信息)
     * @return
     */
    @RequestMapping(value = "/loginUserInfo")
    @ResponseBody
    public MsgBean loginUserInfo() {
        String message = null;
        try {
            if (null != super.getUserId() && !StringUtils.isEmpty(super.getUserName())) {
                UserBaseDto userBaseDto = new UserBaseDto();
                userBaseDto.setId(super.getUserId());
                userBaseDto.setUserName(super.getUserName());
                message = "获取用户登录信息成功";
                logger.info("============== : " + message);
                return super.encapsulateMsgBean(userBaseDto, MsgBean.MsgCode.SUCCESS, message);
            } else {
                message = "获取用户登录信息失败";
                logger.info("============== : " + message);
                return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, message);
            }
        } catch (Exception e) {
            logger.error("获取用户登录信息失败：" + e.getMessage());
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * @Description TODO(修改密码)
     * @param userDto
     * @return MsgBean
     */
    @RequestMapping(value = "/updatePassword")
    @ResponseBody
    public MsgBean updatePassword(@RequestBody UserDto userDto) {
        try {
            Param oldPassword = new Param.Builder("旧密码", Param.ParamType.STR_NORMAL.getType(), userDto.getOldPassword(),
                    false).build();
            Param newPassword = new Param.Builder("新密码", Param.ParamType.STR_NORMAL.getType(), userDto.getNewPassword(),
                    false).build();
            Param confirmPassword = new Param.Builder("确认密码", Param.ParamType.STR_NORMAL.getType(),
                    userDto.getConfirmPassword(), false).build();
            super.validateParams(oldPassword, newPassword, confirmPassword);
            if (userDto.getOldPassword().equalsIgnoreCase(userDto.getNewPassword())) {
                throw new IllegalArgumentException("旧密码与新密码不能相同");
            }
            if (!userDto.getNewPassword().equalsIgnoreCase(userDto.getConfirmPassword())) {
                throw new IllegalArgumentException("新密码与确认密码必须相同");
            }
            UserDto uDto = userService.loadUserById(super.getUserId());
            if (null == uDto) {
                throw new IllegalArgumentException("用户不存在");
            }
            if (!uDto.getPassword().equalsIgnoreCase(userDto.getOldPassword())) {
                throw new IllegalArgumentException("旧密码输入不正确，请重新输入");
            }
            uDto.setPassword(userDto.getNewPassword());
            userService.updateUserForPassword(uDto);
            String message = "修改密码成功";
            logger.info("============== : " + message);
            return super.encapsulateMsgBean(userDto, MsgBean.MsgCode.SUCCESS, message);
        } catch (Exception e) {
            logger.error("修改密码失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}
