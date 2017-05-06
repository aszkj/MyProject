/**
 * 文件名称：BaseMapperTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import org.apache.log4j.Logger;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 功能描述：DAO测试基类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring-dao-test.xml" })
public abstract class BaseMapperTest {
	protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 打印信息
	 * 
	 * @param obj
	 *            待打印的对象
	 */
	public void printInfo(Object obj) {
		logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ");
		if (ObjectUtils.isNullOrEmpty(obj)) {
			logger.info("没有查询到数据，返回对象为NULL");
		} else {
			logger.info(obj);
		}
		logger.info("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
	}

}
