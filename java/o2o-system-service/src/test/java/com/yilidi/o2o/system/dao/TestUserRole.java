/**
 * 文件名称：TestUserRole.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.UserRoleMapper;
import com.yilidi.o2o.system.model.UserRole;


/**
 * 功能描述：<概要描述>
 * 作者：chenl
 * 
 * BugID: 
 * 修改内容：
 */
public class TestUserRole extends BaseMapperTest {
	
	@Autowired
	private UserRoleMapper userRoleMapper;
	
	@Test
	public void testList() {
		List<UserRole> urs = userRoleMapper.listByRoleId(2);
		printInfo(urs);
	}
	
	
	@Test
	public void testSave() {
		UserRole ur = new UserRole();
		ur.setUserId(3);
		ur.setRoleId(4);
		ur.setCreateTime(new Date());
		ur.setCreateUserId(1);
		userRoleMapper.save(ur);
		printInfo("生成的主键Id： " + ur.getId());
	}
	
	@Test
	public void testDelete() {
		Integer rtn = userRoleMapper.deleteByRoleId(4);
		printInfo("影响的行数： " + rtn);
	}
}
