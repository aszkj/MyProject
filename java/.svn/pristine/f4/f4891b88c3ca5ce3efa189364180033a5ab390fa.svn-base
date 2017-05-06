package com.yilidi.o2o.system.dao;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.PermissionHistoryMapper;
import com.yilidi.o2o.system.model.PermissionHistory;

/**
 * 文件名称：TestPermissionHistory.java<br/>
 * 
 * 描述： <br/>
 * 
 *
 */

/**
 * 功能描述：<概要描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestPermissionHistory extends BaseMapperTest {

	
	@Autowired
	private PermissionHistoryMapper permissionHistoryMapper;
	
	@Test	
	public void testList() {
		List<PermissionHistory> his = permissionHistoryMapper.list();
		printInfo(his);
	}
	
	
	@Test	
	public void testListByPermissionName() {
		List<PermissionHistory> his = permissionHistoryMapper.listByPermissionName("添加");
		printInfo(his);
	}
	
	@Test	
	public void testListPermissionId() {
		List<PermissionHistory> his = permissionHistoryMapper.listByPermissionId(2);
		printInfo(his);
	}
}
