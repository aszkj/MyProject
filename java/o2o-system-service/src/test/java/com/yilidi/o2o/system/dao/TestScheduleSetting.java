/**
 * 文件名称：TestScheduleSetting.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.dao.ScheduleSettingMapper;
import com.yilidi.o2o.system.model.ScheduleSetting;

/**
 * 功能描述：<概要描述>
 * 作者：chenl
 * 
 * BugID: 
 * 修改内容：
 */
public class TestScheduleSetting extends BaseMapperTest {

	@Autowired
	private ScheduleSettingMapper scheduleSettingMapper;
	
	@Test
	public void testList() {
		
		List<ScheduleSetting> settings = scheduleSettingMapper.list();
		printInfo(settings);
	}
}
