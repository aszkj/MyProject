/**
 * 文件名称：TestRolePermissionHistory.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.RolePermissionHistoryMapper;
import com.yilidi.o2o.system.model.RolePermissionHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestRolePermissionHistory extends BaseMapperTest {

	@Autowired
	private RolePermissionHistoryMapper rolePermissionHistoryMapper;
	
	@Test
	public void testList() {
		List<RolePermissionHistory> rphs = rolePermissionHistoryMapper.list();
		printInfo(rphs);
	}
}
