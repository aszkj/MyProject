/**
 * 文件名称：TestSystemLog.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.system.model.SysOperationLog;

/**
 * 功能描述：<概要描述> 作者：chenl
 * 
 * BugID: 修改内容：
 */
public class TestSystemLog extends BaseMapperTest {

	@Autowired
	private SysOperationLogMapper sysOperationLogMapper;

	@Test
	public void testSave() {

		SysOperationLog log = new SysOperationLog();

		log.setUserName("admin");
		log.setRequestUrl("/user/add");
		log.setCostTime(20);
		log.setRemoteIp("192.168.2.35");
		log.setCreateTime(new Date());
		log.setRequestMethod("Get");
		log.setLogType("0");
		sysOperationLogMapper.save(log);
		printInfo("保存后生成的主键id为： " + log.getLogId());
	}

}
