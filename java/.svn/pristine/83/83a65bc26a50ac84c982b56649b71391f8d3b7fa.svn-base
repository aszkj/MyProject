/**
 * 文件名称：TestSiteMessage.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SiteMessageMapper;
import com.yilidi.o2o.system.model.SiteMessage;

/**
 * 功能描述：<概要描述>
 * 作者：chenl
 * 
 * BugID: 
 * 修改内容：
 */
public class TestSiteMessage extends BaseMapperTest {

	@Autowired
	private SiteMessageMapper siteMessageMapper;
	
	@Test
	public void testList() {
		List<SiteMessage> msgs = siteMessageMapper.list();
		printInfo(msgs);
	}
}
