/**
 * 文件名称：TestRolePermission.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.RolePermissionMapper;
import com.yilidi.o2o.system.model.RolePermission;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestRolePermission extends BaseMapperTest {

	@Autowired
	private RolePermissionMapper rolePermissionMapper;
	
	@Test
	public void testList() {
		List<RolePermission> rps = rolePermissionMapper.listByPermissionId(1);
		printInfo(rps);
	}
}
