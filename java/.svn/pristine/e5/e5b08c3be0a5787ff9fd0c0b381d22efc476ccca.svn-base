/**
 * 文件名称：TestSystemAnnouncement.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.SystemAnnouncementMapper;
import com.yilidi.o2o.system.model.SystemAnnouncement;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class TestSystemAnnouncement extends BaseMapperTest {
	
	@Autowired
	private SystemAnnouncementMapper systemAnnouncementMapper;

	@Test
	public void testList() {
		List<SystemAnnouncement> sas = systemAnnouncementMapper.list();
		printInfo(sas);
	}
}
