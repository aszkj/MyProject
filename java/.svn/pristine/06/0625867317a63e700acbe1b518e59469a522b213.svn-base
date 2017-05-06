/**
 * 文件名称：TestRemotingService.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o;

import java.util.HashSet;

import javassist.expr.NewArray;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.exception.ServiceLevelException;
import com.yilidi.o2o.user.service.IUserService;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml",
		"classpath:spring-hessian.xml" })
public class TestRemotingService {

	private final Logger logger = Logger.getLogger(TestRemotingService.class);

	@Autowired
	IUserService userService;

	@Test
	public void TestRemotingUserSerivce() throws ServiceLevelException {

		/*Integer id = 10;
		UserDto u;
		try {
			u = userService.loadUserById(id);
			logger.info(JSON.toJsonStringWithDateFormat(u));
		} catch (UserServiceException e) {
			e.printStackTrace();
		}*/

	}
}
