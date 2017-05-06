/**
 * 文件名称：TestSiteMessageHistory.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SiteMessageHistoryMapper;
import com.yilidi.o2o.system.model.SiteMessageHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestSiteMessageHistory extends BaseMapperTest {

	
	@Autowired
	private SiteMessageHistoryMapper siteMessageHistoryMapper;
	
	@Test
	public void testList() {
		
		List<SiteMessageHistory> smhs = siteMessageHistoryMapper.list();
		printInfo(smhs);
	}
}
