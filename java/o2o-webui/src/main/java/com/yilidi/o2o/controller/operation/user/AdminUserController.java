package com.yilidi.o2o.controller.operation.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.controller.common.OperationBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.user.service.ICustomerService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.AdminUserInfoDto;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * @Description:TODO(系统管理员(用户管理)控制器)
 * @author: llp
 * @date: 2015年11月20日 下午11:12:48
 * 
 */
@Controller
@RequestMapping(value = "/operation")
public class AdminUserController extends OperationBaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IUserService userService;

    @Autowired
    private ICustomerService customerService;

    private static final String DEFAULT_PASSWORD = "123456";

    /**
     * @Description TODO(查询后台管理用户管理列表)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/listAdminUser")
    @ResponseBody
    public MsgBean listAdminUser(@RequestBody UserQuery query) {
        try {
            // 系统管理员(运营人员)
            query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
            query.setOrder("CREATETIME");
            query.setSort("desc");
            YiLiDiPage<AdminUserInfoDto> page = userService.findAdminUsers(query);
            return super.encapsulateMsgBean(page, MsgBean.MsgCode.SUCCESS, "查询后台管理用户管理列表成功");
        } catch (Exception e) {
            logger.error("查询后台管理用户管理列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * 
     * @Description TODO(获取部门列表)
     * @return MsgBean
     */
    @RequestMapping(value = "/getDepartment")
    @ResponseBody
    public MsgBean getDepartment() {
        try {
            List<Map<String, String>> departmentMapList = systemBasicDataInfoUtils
                    .getSystemDictInfoList(SystemContext.UserDomain.DictType.OPERATORDEPARTMENTTYPE.getValue());
            return super.encapsulateMsgBean(departmentMapList, MsgBean.MsgCode.SUCCESS, "获取部门列表成功");
        } catch (Exception e) {
            logger.error("获取部门列表失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据用户ID查询用户详情信息)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/loadAdminUserById")
    @ResponseBody
    public MsgBean loadAdminUserById(@PathVariable("id") Integer id) {
        try {
            UserDto userDto = userService.loadUserById(id);
            return super.encapsulateMsgBean(userDto, MsgBean.MsgCode.SUCCESS, "查询用户详细信息成功");
        } catch (Exception e) {
            logger.error("查询用户详细信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(根据用户ID查询用户名是否已经注册)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/{userName}/checkUserNameIsExist")
    @ResponseBody
    public MsgBean checkUserNameIsExist(@PathVariable("userName") String userName) {
        try {
            Boolean flag = userService.checkUserNameIsExist(userName, SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
            return super.encapsulateMsgBean(flag, MsgBean.MsgCode.SUCCESS, "查询用户名是否存在信息成功");
        } catch (Exception e) {
            logger.error("查询用户名是否存在信息失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(新建后台用户，保存操作)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/saveAdminUser")
    @ResponseBody
    public MsgBean saveAdminUser(@RequestBody UserDto userDto) {
        try {
            Param userName = new Param.Builder("登录账号", Param.ParamType.STR_NORMAL.getType(), userDto.getUserName(), false)
                    .build();
            Param realName = new Param.Builder("真实姓名", Param.ParamType.STR_NORMAL.getType(), userDto.getRealName(), false)
                    .build();
            Param phone = new Param.Builder("手机号码", Param.ParamType.STR_MOBILE.getType(), userDto.getPhone(), false).build();
            Param email = new Param.Builder("用户邮箱", Param.ParamType.STR_EMAIL.getType(), userDto.getEmail(), false).build();
            Param department = new Param.Builder("所在部门", Param.ParamType.STR_NORMAL.getType(), userDto.getDepartment(),
                    false).build();
            Param invitationCode = new Param.Builder("邀请码", Param.ParamType.STR_NORMAL.getType(),
                    userDto.getInvitationCode(), true).build();
            Param statusCode = new Param.Builder("是否有效", Param.ParamType.STR_NORMAL.getType(), userDto.getStatusCode(),
                    false).build();
            Param note = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), userDto.getNote(), true)
                    .maxLength(50).build();
            super.validateParams(userName, realName, phone, email, department, invitationCode, statusCode, note);
            if (!StringUtils.isEmpty(userDto.getInvitationCode())) {
                CustomerDto cto = customerService.loadByInvitationCode(userDto.getInvitationCode());
                if (null != cto) {
                    String msg = "邀请码重复";
                    logger.error(msg);
                    return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
                }
            }
            userDto.setPassword(EncryptUtils.md5Crypt(DEFAULT_PASSWORD));
            userDto.setCreateUserId(super.getUserId());
            userDto.setCreateTime(new Date());
            userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
            userService.saveAdminUser(userDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "新增后台管理用户成功");
        } catch (Exception e) {
            logger.error("新增后台管理用户失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(修改后台用户，修改操作)
     * @param query
     * @return MsgBean
     */
    @RequestMapping(value = "/updateAdminUser")
    @ResponseBody
    public MsgBean updateAdminUser(@RequestBody UserDto userDto) {
        try {
            Param userName = new Param.Builder("登录账号", Param.ParamType.STR_NORMAL.getType(), userDto.getUserName(), false)
                    .build();
            Param realName = new Param.Builder("真实姓名", Param.ParamType.STR_NORMAL.getType(), userDto.getRealName(), false)
                    .build();
            Param phone = new Param.Builder("手机号码", Param.ParamType.STR_MOBILE.getType(), userDto.getPhone(), false).build();
            Param email = new Param.Builder("用户邮箱", Param.ParamType.STR_EMAIL.getType(), userDto.getEmail(), false).build();
            Param department = new Param.Builder("所在部门", Param.ParamType.STR_NORMAL.getType(), userDto.getDepartment(),
                    false).build();
            Param invitationCode = new Param.Builder("邀请码", Param.ParamType.STR_NORMAL.getType(),
                    userDto.getInvitationCode(), true).build();
            Param statusCode = new Param.Builder("是否有效", Param.ParamType.STR_NORMAL.getType(), userDto.getStatusCode(),
                    false).build();
            Param note = new Param.Builder("备注", Param.ParamType.STR_NORMAL.getType(), userDto.getNote(), true)
                    .maxLength(50).build();
            super.validateParams(userName, realName, phone, email, department, invitationCode, statusCode, note);
            if (!StringUtils.isEmpty(userDto.getInvitationCode())) {
                CustomerDto cto = customerService.loadByInvitationCode(userDto.getInvitationCode());
                if (null != cto) {
                    UserDto uDto = userService.loadMainUser(cto.getId(), SystemContext.UserDomain.USERMASTERFLAG_MAIN);
                    if (null != uDto && uDto.getId().intValue() != userDto.getId()) {
                        String msg = "邀请码重复";
                        logger.error(msg);
                        return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, msg);
                    }
                }
            }
            userDto.setModifyUserId(super.getUserId());
            userDto.setModifyTime(new Date());
            userDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
            customerService.updateAdminUser(userDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "修改后台管理用户成功");
        } catch (Exception e) {
            logger.error("修改后台管理用户失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    /**
     * @Description TODO(初始化用户密码，修改操作)
     * @param id
     * @return MsgBean
     */
    @RequestMapping(value = "/{id}/resetPassword")
    @ResponseBody
    public MsgBean resetPassword(@PathVariable("id") Integer id) {
        try {
            UserDto userDto = new UserDto();
            userDto.setId(id);
            userDto.setModifyUserId(super.getUserId());
            userDto.setModifyTime(new Date());
            userDto.setPassword(EncryptUtils.md5Crypt(DEFAULT_PASSWORD));
            customerService.updateCustomerForPassword(userDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "初始化用户密码成功");
        } catch (Exception e) {
            logger.error("初始化用户密码失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

    @RequestMapping(value = "/{id}-{statusCode}/changeUserStatus")
    @ResponseBody
    public MsgBean changeUserStatus(@PathVariable("id") Integer id, @PathVariable("statusCode") String statusCode) {
        try {
            UserDto userDto = new UserDto();
            userDto.setId(id);
            userDto.setModifyUserId(super.getUserId());
            userDto.setModifyTime(new Date());
            userDto.setStatusCode(statusCode);
            customerService.updateCustomerForStatus(userDto);
            return super.encapsulateMsgBean(MsgBean.MsgCode.SUCCESS, "更新用户状态成功");
        } catch (Exception e) {
            logger.error("更新用户状态失败：" + e.getMessage(), e);
            return super.encapsulateMsgBean(MsgBean.MsgCode.FAILURE, e.getMessage());
        }
    }

}