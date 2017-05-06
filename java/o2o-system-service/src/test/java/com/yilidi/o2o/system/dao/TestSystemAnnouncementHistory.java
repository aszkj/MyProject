/**
 * 文件名称：TestSystemAnnouncementHistory.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SystemAnnouncementHistoryMapper;
import com.yilidi.o2o.system.model.SystemAnnouncementHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestSystemAnnouncementHistory extends BaseMapperTest {

	@Autowired
	private SystemAnnouncementHistoryMapper systemAnnouncementHistoryMapper;
	
	@Test
	public void testList() {
		
		List<SystemAnnouncementHistory> sahs = systemAnnouncementHistoryMapper.list();
		printInfo(sahs);
		
	}
	
}
