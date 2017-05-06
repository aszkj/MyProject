/**
 * 文件名称：TestSiteMessagePublished.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SiteMessagePublishedMapper;
import com.yilidi.o2o.system.model.SiteMessagePublished;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestSiteMessagePublished extends BaseMapperTest {

	@Autowired
	private SiteMessagePublishedMapper siteMessagePublishedMapper;
	
	@Test
	public void testList() {
		List<SiteMessagePublished> smps = siteMessagePublishedMapper.listByReceiveId(1);
		
		printInfo(smps);
	}
}
