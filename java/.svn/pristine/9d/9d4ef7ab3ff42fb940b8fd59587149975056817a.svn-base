/**
 * 文件名称：TestSystemDict.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.dao;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.system.model.SystemDict;

/**
 * 功能描述：<概要描述> 作者：chenl
 * 
 * BugID: 修改内容：
 */
public class TestSystemDict extends BaseMapperTest {

	@Autowired
	private SystemDictMapper systemDictMapper;

	@Test
	public void testList() {
		List<SystemDict> list = systemDictMapper
				.listAllValidDictByDictType(SystemContext.SystemDomain.DictType.PERMISSIONSTATUS.getValue());
		printInfo(list);
	}

	@Test
	public void testGetDictType() {
		List<Map<String, String>> typeList = systemDictMapper.listAllValidDictType();
		printInfo(typeList);

		for (Map<String, String> dict : typeList) {
			printInfo(dict);
		}
	}

	/**
	 * 测试分页
	 */
	@Test
	public void testPage() {
		PageHelper.startPage(1, 10);
		List<SystemDict> logs = systemDictMapper.listAllValidDictByDictType(null);
		PageInfo<SystemDict> page = new PageInfo<SystemDict>(logs);

		printInfo("总共有: " + page.getPages() + " 页");
		printInfo("总共有: " + page.getTotal() + " 条记录");

	}

	@Test
	public void testListByDictName() {

		List<SystemDict> sds = systemDictMapper.listByDictName(null);
		printInfo(sds);
	}

	@Test
	public void testLoadByDictCode() {

		SystemDict sd = systemDictMapper.loadByDictCode("0");
		printInfo(sd);
	}

}
