/**
 * 文件名称：TestRoleHistory.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.RoleHistoryMapper;
import com.yilidi.o2o.system.model.RoleHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestRoleHistory extends BaseMapperTest {

	@Autowired
	private RoleHistoryMapper roleHistoryMapper;
	
	@Test
	public void testList() {
		List<RoleHistory> rhis = roleHistoryMapper.list();
		printInfo(rhis);
	}
}
