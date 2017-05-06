/**
 * 文件名称：TestSystemParamsHistory.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SystemParamsHistoryMapper;
import com.yilidi.o2o.system.model.SystemParamsHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestSystemParamsHistory extends BaseMapperTest {

	@Autowired
	private SystemParamsHistoryMapper systemParamsHistoryMapper;
	
	@Test
	public void testList() {
		List<SystemParamsHistory> sphs = systemParamsHistoryMapper.list();
		printInfo(sphs);
		
	}
	
}
