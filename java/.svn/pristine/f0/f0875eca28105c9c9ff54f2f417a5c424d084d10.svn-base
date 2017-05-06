package com.yilidi.o2o.core.connect.wechat.cache;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.connect.wechat.javabean.JsapiTicket;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;

public class RedisJsapiTicketCache implements IJsapiTicketCache {

	private final String CACHEKEY_PREFIX = "yld_weixin_jsapi:";
	private int timeOut = 0;

	public RedisJsapiTicketCache() {
	}

	public RedisJsapiTicketCache(int cacheTime) {
		this.timeOut = cacheTime;
	}

	@Override
	public JsapiTicket get(String key) {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getJedis();
			if (jedis.hexists(CACHEKEY_PREFIX.getBytes(), key.getBytes())) {
				byte[] byteArray = jedis.hget(CACHEKEY_PREFIX.getBytes(), key.getBytes());
				return (JsapiTicket) SerializableUtils.read(byteArray);
			}
			return null;
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public void set(String key, Object value, int timeOut) {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getJedis();
			jedis.hset(CACHEKEY_PREFIX.getBytes(), key.getBytes(), SerializableUtils.write(value));
			if (timeOut != 0) {
				jedis.expire(key, timeOut);
			}
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	@Override
	public void remove(String key) {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getJedis();
			jedis.hdel(CACHEKEY_PREFIX.getBytes(), key.getBytes());
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	public int getTimeOut() {
		return timeOut;
	}

	public void setTimeOut(int timeOut) {
		this.timeOut = timeOut;
	}

	@Override
	public void set(String key, Object value) {
		set(key, value, timeOut);
	}

}
