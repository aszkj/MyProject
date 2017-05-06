package com.yilidi.o2o.controller.warehouse.system;

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
import com.yilidi.o2o.controller.common.WarehouseBaseController;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.service.IPermissionService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.query.PermissionQuery;

/**
 * 权限Controller
 * 
 * @author: chenb
 * @date: 2016年7月6日 下午5:06:51
 */
@Controller("warehousePermissionController")
@RequestMapping(value = "/warehouse")
public class PermissionController extends WarehouseBaseController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    private IPermissionService permissionService;

    /**
     * 
     * 获取用户的菜单权限
     * 
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
     * 获取用户的功能权限
     * 
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
     * 查询权限菜单
     * 
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
     * 根据ID获取菜单权限信息
     * 
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
     * 根据权限编码验证该编码是否存在
     * 
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
     * 获取一级菜单列表
     * 
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
     * 获取二级菜单列表
     * 
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
     * 获取功能列表
     * 
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
}
