package com.yilidi.o2o.system.service;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.dto.PermissionDto;

/**
 * 
 * @Description:TODO(测试权限Service)
 * @author: chenlian
 * @date: 2015年11月7日 上午10:25:44
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestPermissionService {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IPermissionService permissionService;

	@Test
	public void testSave() {
		PermissionDto permissionDto = new PermissionDto();
		permissionDto.setPermissionName("菜单管理");
		permissionDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
		permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_SECOND_MENU);
		permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
		permissionDto.setPermissionDesc("菜单管理");
		permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
		permissionDto.setParentId(1);
		permissionDto.setParentName("系统管理");
		permissionDto.setCreateUserId(4);
		permissionDto.setCreateTime(new Date());
		try {
			permissionService.save(permissionDto);
		} catch (SystemServiceException e) {
			logger.error(e);
		}
	}

	@Test
	public void testListPermissions() throws UserServiceException {
		try {
			PermissionDto permissionDto = new PermissionDto();
			permissionDto.setPermissionLevel(SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU);
			permissionDto.setPermissionType(SystemContext.SystemDomain.PERMISSIONTYPE_MENU);
			permissionDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			permissionDto.setPermissionStatus(SystemContext.SystemDomain.PERMISSIONSTATUS_ON);
			List<PermissionDto> permissionDtoList = permissionService.listPermissions(permissionDto);
			if (!ObjectUtils.isNullOrEmpty(permissionDtoList)) {
				for (PermissionDto dto : permissionDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(dto));
				}
			}
		} catch (Exception e) {
			logger.error("testListPermissions异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListUserPermissions() throws UserServiceException {
		try {
			String customerType = SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR;
			String permissionLevel = SystemContext.SystemDomain.PERMISSIONLEVEL_FIRST_MENU;
			String permissionStatus = SystemContext.SystemDomain.PERMISSIONSTATUS_ON;
			Integer userId = 4;
			Integer parentId = null;
			List<PermissionDto> permissionDtoList = permissionService.listUserPermissions(customerType, permissionLevel,
					permissionStatus, userId, parentId);
			if (!ObjectUtils.isNullOrEmpty(permissionDtoList)) {
				for (PermissionDto dto : permissionDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(dto));
				}
			}
		} catch (Exception e) {
			logger.error("testListUserPermissions异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
