package com.yilidi.o2o.core.utils;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

/**
 * 
 * Redis操作工具类
 * 
 * @author: chenlian
 * @date: 2015年11月25日 下午4:50:30
 * 
 */
public final class JedisUtils {

    protected static Logger logger = Logger.getLogger(JedisUtils.class);

    private static Map<String, String> redisConfigParams = new HashMap<String, String>();

    /**
     * 私有构造器.
     */
    private JedisUtils() {
    }

    /**
     * 获取Redis配置
     */
    static {
        redisConfigParams = PropertiesUtils.get("redis.properties");
    }

    // Redis服务器IP
    private static final String ADDR_ARRAY = redisConfigParams.get("redis.ip");

    // Redis的端口号
    private static final int PORT = Integer.parseInt(redisConfigParams.get("redis.port"));

    // Redis服务密码
    private static final int USE_REDIS_PWD_FLAG = Integer.parseInt(redisConfigParams.get("redis.use.pwd.flag"));

    // Redis服务密码
    private static final String REDIS_PASSWORD = redisConfigParams.get("redis.password");

    // 可用连接实例的最大数目，默认值为8；
    // 如果赋值为-1，则表示不限制；如果pool已经分配了maxActive个jedis实例，则此时pool的状态为exhausted(耗尽)。
    private static final int MAX_ACTIVE = Integer.parseInt(redisConfigParams.get("jedis.pool.maxActive"));

    // 控制一个pool最多有多少个状态为idle(空闲的)的jedis实例，默认值也是8。
    private static final int MAX_IDLE = Integer.parseInt(redisConfigParams.get("jedis.pool.maxIdle"));

    // 等待可用连接的最大时间，单位毫秒，默认值为-1，表示永不超时。如果超过等待时间，则直接抛出JedisConnectionException；
    private static final int MAX_WAIT = Integer.parseInt(redisConfigParams.get("jedis.pool.maxWait"));

    // 超时时间
    private static final int TIMEOUT = Integer.parseInt(redisConfigParams.get("jedis.pool.timeout"));

    // 驱逐对象的时间设置，即空闲多长时间会被驱逐出池里, 单位分钟
    private static final int EVICT_TIME = Integer.parseInt(redisConfigParams.get("jedis.pool.evict_time"));

    // 驱逐线程扫描间隔，单位秒
    private static final int EVICT_INTERVAL = Integer.parseInt(redisConfigParams.get("jedis.pool.evict_interval"));

    private static JedisPool jedisPool = null;

    /**
     * 初始化Redis连接池
     */
    private static void initialPool() {
        try {
            JedisPoolConfig config = new JedisPoolConfig();
            config.setMaxTotal(MAX_ACTIVE);
            config.setMaxIdle(MAX_IDLE);
            config.setMaxWaitMillis(MAX_WAIT);
            config.setTestOnBorrow(false);
            config.setTestOnReturn(false);
            config.setMinEvictableIdleTimeMillis(1000L * 60L * EVICT_TIME);
            config.setTimeBetweenEvictionRunsMillis(1000L * EVICT_INTERVAL);
            config.setNumTestsPerEvictionRun(-1);
            if (0 == USE_REDIS_PWD_FLAG) {
                // 如果密码为空或者没有设置这个配置，则调用不使用密码的方式创建jedis连接池
                jedisPool = new JedisPool(config, ADDR_ARRAY, PORT, TIMEOUT);
            } else {
                // 如果密码不为空，则调用使用密码的方式创建jedis连接池
                jedisPool = new JedisPool(config, ADDR_ARRAY, PORT, TIMEOUT, REDIS_PASSWORD);
            }
        } catch (Exception e) {
            logger.error("初始化Jedis连接池出现系统异常，信息如下：\n");
            logger.error(e);
        }
    }

    /**
     * 在多线程环境同步初始化
     */
    private static synchronized void poolInit() {
        if (jedisPool == null) {
            initialPool();
        }
    }

    /**
     * 同步获取Jedis实例
     * 
     * @return Jedis对象
     */
    public static synchronized Jedis getJedis() {
        if (jedisPool == null) {
            poolInit();
        }
        Jedis jedis = null;
        try {
            if (jedisPool != null) {
                jedis = jedisPool.getResource();
            }
        } catch (Exception e) {
            logger.error("获取Jedis实例出现系统异常，信息如下：\n");
            logger.error(e);
        }
        return jedis;
    }

    /**
     * 释放jedis资源
     * 
     * @param jedis
     *            jedis对象
     */
    public static void returnResource(final Jedis jedis) {
        if (jedis != null && jedisPool != null) {
            jedisPool.returnResource(jedis);
        }
    }

}
