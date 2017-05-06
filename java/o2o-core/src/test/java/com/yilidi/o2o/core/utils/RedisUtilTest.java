/**
 * 文件名称：RedisUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.util.Set;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.model.Address;

/**
 * 功能描述： 作者：chenl
 * 
 * 
 */
public class RedisUtilTest {

	Logger logger = Logger.getLogger(this.getClass());

	Jedis jedis = null;

	@Before
	public void before() throws Exception {
		jedis = JedisUtils.getJedis();
	}

	@Test
	public void testSet() {

		for (int i = 0; i < 10; i++) {
			jedis.set("test" + i, "from java client " + i);
			logger.info(jedis.get("test" + i));
		}
	}

	@Test
	public void testGet() {
		// jedis.set("test", "from java client");

		// String use = jedis.hget("userLoginFail", "use");

		// logger.info("use =====> " + use);

		// jedis.keys
		Set<String> keys = jedis.keys("*");
		for (String key : keys) {
			logger.info(key);
			// logger.info(jedis.hgetAll(key));
		}

		// jedis.hkeys(key)

	}

	@Test
	public void testClear() {

		Set<String> keys = jedis.keys("*");
		for (String key : keys) {
			logger.info(key);
			jedis.del(key);
		}
	}

	/**
	 * 通过hash存储数据
	 */
	@Test
	public void testHashSet() {

		Address add1 = new Address(1, "深南大道128号 三楼");
		Address add2 = new Address(1, "梅坂大道 滢水 三楼");

		jedis.hset("address", "home", JsonUtils.toJsonStringWithDateFormat(add2));
		jedis.hset("address", "office", JsonUtils.toJsonStringWithDateFormat(add1));

		logger.info(jedis.hlen("address"));

	}

	/**
	 * 从hash中获取数据
	 */
	@Test
	public void testHashGet() {

		jedis.hdel("address", "home");

		String homeJson = jedis.hget("address", "home");
		logger.info("homeJson =====> " + homeJson);

		Address home = (Address) JsonUtils.parseObject(homeJson, Address.class);

		logger.info(home);
	}

	@Test
	public void testHashGet2() {

		String sql = jedis.hget("user", "sql1");
		logger.info("sql =====> " + sql);

	}

	@Test
	public void testHashExists() {

		boolean sql = jedis.hexists("user", "sql2");
		logger.info("sql =====> " + sql);

	}

	/**
	 * redis 模拟 栈
	 */
	@Test
	public void testRedisStackPush() {

		jedis.lpush("color", "红色");
		jedis.lpush("color", "蓝色");
		jedis.lpush("color", "绿色");

		Assert.assertEquals("绿色", jedis.lpop("color"));
		Assert.assertEquals("蓝色", jedis.lpop("color"));
		Assert.assertEquals("红色", jedis.lpop("color"));
	}

	/**
	 * redis 模拟 先进先出队列
	 */
	@Test
	public void testRedisFIFO() {
		jedis.lpush("color", "红色");
		jedis.lpush("color", "蓝色");
		jedis.lpush("color", "绿色");

		Assert.assertEquals("红色", jedis.rpop("color"));
		Assert.assertEquals("蓝色", jedis.rpop("color"));
		Assert.assertEquals("绿色", jedis.rpop("color"));
	}

	@After
	public void after() {
		JedisUtils.returnResource(jedis);
	}
}
