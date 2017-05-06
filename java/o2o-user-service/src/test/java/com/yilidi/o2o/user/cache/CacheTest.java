/**
 * 文件名称：CacheTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.user.cache;

import java.util.List;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.model.User;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 * 
 */
public class CacheTest {

	Logger logger = Logger.getLogger(this.getClass());

	Jedis jedis = null;

	@Before
	public void before() throws Exception {
		jedis = JedisUtils.getJedis();
	}

	@Test
	public void testHGet1() {

		String hashKey = "user";
		String sqlKey = "selectById:5";

		byte[] objBytes = jedis.hget(hashKey.getBytes(), sqlKey.getBytes());

		if (null != objBytes) {
			Object obj = ObjectUtils.toObject(objBytes);
			User u = (User) obj;
			logger.info(JsonUtils.toJsonStringWithDateFormat(u));
		}

	}

	@Test
	public void testHGet2() {

		String hashKey = "user";
		String sqlKey = "getAll";

		byte[] objBytes = jedis.hget(hashKey.getBytes(), sqlKey.getBytes());
		if (null != objBytes) {
			Object obj = ObjectUtils.toObject(objBytes);
			@SuppressWarnings("unchecked")
			List<User> u = (List<User>) obj;
			logger.info(JsonUtils.toJsonStringWithDateFormat(u));
		}
	}

	@After
	public void after() {
		JedisUtils.returnResource(jedis);
	}

}
