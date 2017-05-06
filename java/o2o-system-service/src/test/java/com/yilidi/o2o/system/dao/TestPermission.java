/**
 * 文件名称：TestPermission.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.model.Permission;

/**
 * 功能描述：<概要描述> 作者：chenl
 * 
 * BugID: 修改内容：
 */

public class TestPermission extends BaseMapperTest {

	@Autowired
	PermissionMapper permissionMapper;

	@Test
	public void testSelect() {
		Permission permission = permissionMapper.loadById(2);
		logger.info(permission);
	}

	@Test
	public void testDelete() {
		Integer rtn = permissionMapper.deleteById(51);
		printInfo("影响的行数： " + rtn);
	}

	@Test
	public void testDeleteByParentId() {
		Integer rtn = permissionMapper.deleteByParentId(12);
		printInfo("影响的行数： " + rtn);
	}

}
