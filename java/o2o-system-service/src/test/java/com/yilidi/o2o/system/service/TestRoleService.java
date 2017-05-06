package com.yilidi.o2o.system.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.RoleDto;

/**
 * 
 * @Description:TODO(测试角色Service)
 * @author: chenlian
 * @date: 2015年11月9日 上午9:35:38
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestRoleService {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IRoleService roleservice;

	@Test
	public void testSave() {
		RoleDto roleDto = new RoleDto();
		roleDto.setRoleName("超级管理员");
		roleDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
		roleDto.setRoleDesc("超级管理员");
		roleDto.setCustomerId(4);
		roleDto.setCreateUserId(1111);
		roleDto.setCreateTime(new Date());
		try {
			roleservice.save(roleDto);
		} catch (SystemServiceException e) {
			logger.error(e);
		}
	}
}
