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
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.dao.PermissionHistoryMapper;
import com.yilidi.o2o.system.dao.PermissionMapper;
import com.yilidi.o2o.system.model.Permission;
import com.yilidi.o2o.system.model.PermissionHistory;
import com.yilidi.o2o.system.service.IPermissionService;
import com.yilidi.o2o.system.service.dto.PermissionDto;
import com.yilidi.o2o.system.service.dto.query.PermissionQuery;

/**
 * 
 * @Description:TODO(权限Service服务接口实现类)
 * @author: chenlian
 * @date: 2015年11月5日 下午9:38:13
 * 
 */
@Service("permissionService")
public class PermissionServiceImpl extends BaseService implements IPermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private PermissionHistoryMapper permissionHistoryMapper;

    @Override
    public void save(PermissionDto permissionDto) throws SystemServiceException {
        try {
            Permission permissionForCode = this.permissionMapper.loadByPermissionCode(permissionDto.getPermissionCode());
            if (null != permissionForCode) {
                throw new IllegalArgumentException("权限编码已经存在");
            }
            Permission permission = new Permission();
            ObjectUtils.fastCopy(permissionDto, permission);
            this.permissionMapper.save(permission);
            PermissionHistory permissionHistory = new PermissionHistory();
            ObjectUtils.fastCopy(permissionDto, permissionHistory);
            permissionHistory.setPermissionId(permission.getId());
            permissionHistory.setOperateUserId(permission.getCreateUserId());
            permissionHistory.setOperateTime(permission.getCreateTime());
            permissionHistory.setOperateType(SystemContext.SystemDomain.PERMISSIONOPERTYPE_CREATE);
            permissionHistoryMapper.save(permissionHistory);
        } catch (Exception e) {
            String msg = "";
            if (!StringUtils.isEmpty(e.getMessage())) {
                msg = e.getMessage();
            } else {
                msg = "创建权限信息出现系统异常";
            }
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public List<PermissionDto> listPermissions(PermissionDto permissionDto) throws SystemServiceException {
        try {
            Permission permission = new Permission();
            ObjectUtils.fastCopy(permissionDto, permission);
            List<Permission> permissionList = this.permissionMapper.listPermissions(permission);
            List<PermissionDto> permissionDtoList = new ArrayList<PermissionDto>();
            if (!ObjectUtils.isNullOrEmpty(permissionList)) {
                for (Permission model : permissionList) {
                    PermissionDto dto = new PermissionDto();
                    ObjectUtils.fastCopy(model, dto);
                    permissionDtoList.add(dto);
                }
            }
            // logger.info("===========permissionDtoList : " + JsonUtils.toJsonStringWithDateFormat(permissionDtoList));
            return permissionDtoList;
        } catch (Exception e) {
            String msg = "查询权限列表出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public List<PermissionDto> listUserPermissions(String customerType, String permissionLevel, String permissionStatus,
            Integer userId, Integer parentId) throws SystemServiceException {
        try {
            List<Permission> permissionList = this.permissionMapper.listUserPermissions(customerType, permissionLevel,
                    permissionStatus, userId, parentId);
            List<PermissionDto> permissionDtoList = new ArrayList<PermissionDto>();
            if (!ObjectUtils.isNullOrEmpty(permissionList)) {
                for (Permission model : permissionList) {
                    PermissionDto dto = new PermissionDto();
                    ObjectUtils.fastCopy(model, dto);
                    permissionDtoList.add(dto);
                }
            }
            // logger.info("===========permissionDtoList : " + JsonUtils.toJsonStringWithDateFormat(permissionDtoList));
            return permissionDtoList;
        } catch (Exception e) {
            String msg = "获取用户拥有的权限列表出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<PermissionDto> findPermissions(PermissionQuery permissionQuery) throws SystemServiceException {
        try {
            if (null == permissionQuery.getStart() || permissionQuery.getStart() <= 0) {
                permissionQuery.setStart(1);
            }
            if (null == permissionQuery.getPageSize() || permissionQuery.getPageSize() <= 0) {
                permissionQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(permissionQuery.getStart(), permissionQuery.getPageSize());
            Page<Permission> page = this.permissionMapper.findPermissions(permissionQuery);
            Page<PermissionDto> pageDto = new Page<PermissionDto>(permissionQuery.getStart(), permissionQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<Permission> permissions = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(permissions)) {
                for (Permission permission : permissions) {
                    PermissionDto permissionDto = new PermissionDto();
                    ObjectUtils.fastCopy(permission, permissionDto);
                    pageDto.add(permissionDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            String msg = "分页获取用户的权限信息出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public PermissionDto loadPermissionById(Integer id) throws SystemServiceException {
        try {
            Permission permission = this.permissionMapper.loadById(id);
            PermissionDto permissionDto = null;
            if (null != permission) {
                permissionDto = new PermissionDto();
                ObjectUtils.fastCopy(permission, permissionDto);
            }
            return permissionDto;
        } catch (Exception e) {
            String msg = "根据ID获取权限信息出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public PermissionDto loadPermissionByPermissionCode(String permissionCode) throws SystemServiceException {
        try {
            Permission permission = this.permissionMapper.loadByPermissionCode(permissionCode);
            PermissionDto permissionDto = null;
            if (null != permission) {
                permissionDto = new PermissionDto();
                ObjectUtils.fastCopy(permission, permissionDto);
            }
            return permissionDto;
        } catch (Exception e) {
            String msg = "根据权限编码获取权限信息出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public void update(PermissionDto permissionDto) throws SystemServiceException {
        try {
            Integer permissionId = permissionDto.getId();
            if (null != permissionId) {
                Permission permission = this.permissionMapper.loadById(permissionId);
                if (null != permission) {
                    Permission permissionForCode = this.permissionMapper.loadByPermissionCode(permissionDto
                            .getPermissionCode());
                    if (null != permissionForCode) {
                        if (!permission.getPermissionCode().equals(permissionForCode.getPermissionCode())) {
                            throw new IllegalArgumentException("权限编码已经存在");
                        }
                    }
                    permission.setCustomerType(permissionDto.getCustomerType());
                    permission.setPermissionName(permissionDto.getPermissionName());
                    permission.setPermissionCode(permissionDto.getPermissionCode());
                    permission.setPermissionUrl(permissionDto.getPermissionUrl());
                    permission.setSort(permissionDto.getSort());
                    permission.setPermissionDesc(permissionDto.getPermissionDesc());
                    permission.setModifyUser(permissionDto.getModifyUser());
                    permission.setModifyTime(permissionDto.getModifyTime());
                    this.permissionMapper.updateById(permission);
                    PermissionHistory permissionHistory = new PermissionHistory();
                    ObjectUtils.fastCopy(permission, permissionHistory);
                    permissionHistory.setPermissionId(permission.getId());
                    permissionHistory.setOperateUserId(permission.getModifyUser());
                    permissionHistory.setOperateTime(permission.getModifyTime());
                    permissionHistory.setOperateType(SystemContext.SystemDomain.PERMISSIONOPERTYPE_MODIFY);
                    permissionHistoryMapper.save(permissionHistory);
                }
            }
        } catch (Exception e) {
            String msg = "";
            if (!StringUtils.isEmpty(e.getMessage())) {
                msg = e.getMessage();
            } else {
                msg = "创建权限信息出现系统异常";
            }
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    @Override
    public void updateStatus(PermissionDto permissionDto) throws SystemServiceException {
        String msg = null;
        try {
            Integer permissionId = permissionDto.getId();
            if (null != permissionId) {
                Permission permission = this.permissionMapper.loadById(permissionId);
                if (null != permission) {
                    if (permission.getPermissionLevel().equals(SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU)) {
                        updateSinglePermissionStatus(permissionDto, permission);
                        List<Permission> secondPermissionList = this.permissionMapper.listByParentId(permissionId);
                        if (!ObjectUtils.isNullOrEmpty(secondPermissionList)) {
                            for (Permission secondPermission : secondPermissionList) {
                                updateSinglePermissionStatus(permissionDto, secondPermission);
                                List<Permission> functionPermissionList = this.permissionMapper
                                        .listByParentId(secondPermission.getId());
                                if (!ObjectUtils.isNullOrEmpty(functionPermissionList)) {
                                    for (Permission functionPermission : functionPermissionList) {
                                        updateSinglePermissionStatus(permissionDto, functionPermission);
                                    }
                                }
                            }
                        }
                    } else if (permission.getPermissionLevel()
                            .equals(SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU)) {
                        if (permissionDto.getPermissionStatus().equals(SystemContext.SystemDomain.PERMISSIONSTATUS_ON)) {
                            Permission parentPermission = this.permissionMapper.loadById(permission.getParentId());
                            if (null != parentPermission
                                    && parentPermission.getPermissionStatus().equals(
                                            SystemContext.SystemDomain.PERMISSIONSTATUS_OFF)) {
                                msg = "该二级菜单的父级菜单已被禁用，无法启用";
                                throw new IllegalStateException(msg);
                            }
                        }
                        updateSinglePermissionStatus(permissionDto, permission);
                        List<Permission> functionPermissionList = this.permissionMapper.listByParentId(permissionId);
                        if (!ObjectUtils.isNullOrEmpty(functionPermissionList)) {
                            for (Permission functionPermission : functionPermissionList) {
                                updateSinglePermissionStatus(permissionDto, functionPermission);
                            }
                        }
                    } else {
                        if (permissionDto.getPermissionStatus().equals(SystemContext.SystemDomain.PERMISSIONSTATUS_ON)) {
                            Permission parentSecondPermission = this.permissionMapper.loadById(permission.getParentId());
                            if (null != parentSecondPermission
                                    && parentSecondPermission.getPermissionStatus().equals(
                                            SystemContext.SystemDomain.PERMISSIONSTATUS_OFF)) {
                                msg = "该功能的父级二级菜单已被禁用，无法启用";
                                throw new IllegalStateException(msg);
                            }
                            Permission parentFirstPermission = this.permissionMapper.loadById(parentSecondPermission
                                    .getParentId());
                            if (null != parentFirstPermission
                                    && parentFirstPermission.getPermissionStatus().equals(
                                            SystemContext.SystemDomain.PERMISSIONSTATUS_OFF)) {
                                msg = "该功能的父级一级菜单已被禁用，无法启用";
                                throw new IllegalStateException(msg);
                            }
                        }
                        updateSinglePermissionStatus(permissionDto, permission);
                    }
                }
            }
        } catch (Exception e) {
            if (StringUtils.isEmpty(msg)) {
                msg = "修改权限状态出现系统异常";
            }
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

    private void updateSinglePermissionStatus(PermissionDto permissionDto, Permission permission) {
        permission.setPermissionStatus(permissionDto.getPermissionStatus());
        permission.setModifyUser(permissionDto.getModifyUser());
        permission.setModifyTime(permissionDto.getModifyTime());
        this.permissionMapper.updateById(permission);
        PermissionHistory permissionHistory = new PermissionHistory();
        ObjectUtils.fastCopy(permission, permissionHistory);
        permissionHistory.setPermissionId(permission.getId());
        permissionHistory.setOperateUserId(permission.getModifyUser());
        permissionHistory.setOperateTime(permission.getModifyTime());
        permissionHistory.setOperateType(SystemContext.SystemDomain.PERMISSIONOPERTYPE_MODIFY);
        permissionHistoryMapper.save(permissionHistory);
    }

    @Override
    public List<PermissionDto> listByParentId(Integer parentId) throws SystemServiceException {
        try {
            List<Permission> permissionList = this.permissionMapper.listByParentId(parentId);
            List<PermissionDto> permissionDtoList = new ArrayList<PermissionDto>();
            if (!ObjectUtils.isNullOrEmpty(permissionList)) {
                for (Permission model : permissionList) {
                    PermissionDto dto = new PermissionDto();
                    ObjectUtils.fastCopy(model, dto);
                    permissionDtoList.add(dto);
                }
            }
            // logger.info("===========permissionDtoList : " + JsonUtils.toJsonStringWithDateFormat(permissionDtoList));
            return permissionDtoList;
        } catch (Exception e) {
            String msg = "根据父ID获取权限列表出现系统异常";
            logger.error(msg, e);
            throw new SystemServiceException(msg);
        }
    }

}
