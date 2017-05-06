/**
 * 文件名称：TestRole.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.system.model.Role;

/**
 * 功能描述：<概要描述> 作者：chenl
 * 
 * BugID: 修改内容：
 */
public class TestRole extends BaseMapperTest {

	@Autowired
	private RoleMapper roleMapper;

	@Test
	public void testList() {
		List<Role> roles = roleMapper.listByCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
		printInfo(roles);

	}
}
