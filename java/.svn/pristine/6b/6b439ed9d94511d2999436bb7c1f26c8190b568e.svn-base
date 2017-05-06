/**
 * 文件名称：TestSystemParams.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.system.model.SystemParams;

/**
 * 功能描述：<概要描述> 作者：chenl
 * 
 * BugID: 修改内容：
 */
public class TestSystemParams extends BaseMapperTest {

	@Autowired
	private SystemParamsMapper systemParamsMapper;

	@Test
	public void testList() {
		List<SystemParams> sParams = systemParamsMapper.listByParamStatus(SystemContext.SystemDomain.SYSPARAMSTATUS_ON);

		printInfo(sParams);
	}
}
