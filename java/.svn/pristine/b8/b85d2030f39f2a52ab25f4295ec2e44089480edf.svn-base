/**
 * 文件名称：TestSyslogWithSpring.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.ISystemLogService;
import com.yilidi.o2o.system.service.dto.SystemLogDto;

/**
 * 功能描述：<概要描述>
 * 作者：chenl
 * 
 * BugID: 
 * 修改内容：
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml"})
public class TestSyslogWithSpring {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ISystemLogService systemLogService;
	
	@Test
	public void testSaveLog() {
		SystemLogDto log = new SystemLogDto();
		
		log.setUserName("admin");
		log.setRequestUrl("/login");
		log.setCostTime(20);
		log.setRemoteIp("192.168.2.35");
		log.setCreateTime(new Date());
		log.setRequestMethod("Get");
		log.setLogType("0");
		
		try {
			systemLogService.saveLog(log);
		} catch (SystemServiceException e) {
			logger.error(e);
		}
	}
}

