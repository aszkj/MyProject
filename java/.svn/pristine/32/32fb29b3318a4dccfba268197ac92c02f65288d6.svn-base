package com.yilidi.o2o.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.redisson.Config;
import org.redisson.MasterSlaveServersConfig;
import org.redisson.Redisson;
import org.redisson.RedissonClient;
import org.redisson.SingleServerConfig;
import org.redisson.connection.balancer.RandomLoadBalancer;
import org.redisson.core.RLock;

/**
 * 分布式锁工具类
 * 
 * @author: chenlian
 * @date: 2016年6月13日 下午1:20:21
 */
public final class DistributedLockUtils {

    protected static Logger logger = Logger.getLogger(DistributedLockUtils.class);

    private static final String DEPLOYMENT_SINGLE_HOST = "SingleHost";

    private static final String DEPLOYMENT_MASTER_SLAVE = "MasterSlave";

    private static final String GET_RLOCK_BY_KEY_ERROR = "无法获取到指定Key的分布式锁";

    private static final String TRY_TO_LOCK_KEY_RLOCK_ERROR = "尝试锁住指定Key出现系统异常";

    private static final String RLOCK_TIMEOUT_ERROR = "系统繁忙，请求超时！";

    private static Map<String, String> redisConfigParams = new HashMap<String, String>();

    private static final ThreadLocal<List<RLock>> RLOCKLISTTHREADLOCAL = new ThreadLocal<List<RLock>>();

    private static List<RLock> getRLockList() {
        return RLOCKLISTTHREADLOCAL.get();
    }

    private static void removeRLockList() {
        RLOCKLISTTHREADLOCAL.remove();
    }

    /**
     * 私有构造器.
     */
    private DistributedLockUtils() {
    }

    /**
     * 获取Redisson配置
     */
    static {
        redisConfigParams = PropertiesUtils.get("redis.properties");
    }

    /**
     * Redis 部署方式
     */
    private static final String DEPLOYMENT = redisConfigParams.get("redis.deployment");
    /**
     * Redis 单机部署方式 主机地址
     */
    private static final String SINGLE_HOST = redisConfigParams.get("redis.single.host");
    /**
     * Redis服务密码
     */
    private static final int USE_REDIS_PWD_FLAG = Integer.parseInt(redisConfigParams.get("redis.use.pwd.flag"));
    /**
     * Redis服务密码
     */
    private static final String REDIS_PASSWORD = redisConfigParams.get("redis.password");
    /**
     * Redis 主从部署方式 Master与Slave的主机地址
     */
    private static final String MASTER_SLAVE_HOSTS = redisConfigParams.get("redis.master.slave.hosts");
    /**
     * Redis 主从部署方式 Master的主机地址
     */
    private static final String MASTER_HOST = redisConfigParams.get("redis.master.host");
    /**
     * 单机部署方式 redisson连接池大小
     */
    private static final int POOL_SIZE = Integer.parseInt(redisConfigParams.get("redisson.pool.size"));
    /**
     * 主从部署方式 主redisson连接池大小
     */
    private static final int MASTER_POOL_SIZE = Integer.parseInt(redisConfigParams.get("redisson.master.pool.size"));
    /**
     * 主从部署方式 从redisson连接池大小
     */
    private static final int SLAVE_POOL_SIZE = Integer.parseInt(redisConfigParams.get("redisson.slave.pool.size"));

    /**
     * Redisson客户端
     */
    private static RedissonClient redissonClient = null;

    /**
     * 初始化Redisson客户端
     */
    private static void initialClient() {
        String msg = null;
        try {
            Config config = new Config();
            if (DEPLOYMENT_SINGLE_HOST.equals(DEPLOYMENT)) {
                SingleServerConfig singleServerConfig = config.useSingleServer().setAddress(SINGLE_HOST)
                        .setConnectionPoolSize(POOL_SIZE);
                if (0 != USE_REDIS_PWD_FLAG) {
                    singleServerConfig.setPassword(REDIS_PASSWORD);
                }
            }
            if (DEPLOYMENT_MASTER_SLAVE.equals(DEPLOYMENT)) {
                MasterSlaveServersConfig masterSlaveServersConfig = config.useMasterSlaveServers()
                        .setMasterAddress(MASTER_HOST).setLoadBalancer(new RandomLoadBalancer())
                        .addSlaveAddress(MASTER_SLAVE_HOSTS.split(",")).setMasterConnectionPoolSize(MASTER_POOL_SIZE)
                        .setSlaveConnectionPoolSize(SLAVE_POOL_SIZE);
                if (0 != USE_REDIS_PWD_FLAG) {
                    masterSlaveServersConfig.setPassword(REDIS_PASSWORD);
                }
            }

            redissonClient = Redisson.create(config);
        } catch (Exception e) {
            msg = "初始化Redisson客户端出现系统异常";
            logger.error(msg, e);
            throw new IllegalStateException(msg);
        }
    }

    /**
     * 在多线程环境同步初始化
     */
    private static synchronized void clientInit() {
        if (redissonClient == null) {
            initialClient();
        }
    }

    /**
     * 获取指定Key的分布式锁
     * 
     * @param key
     *            key字符串
     * @return RLock
     */
    private static synchronized RLock getLock(String key) {
        String msg = null;
        if (redissonClient == null) {
            clientInit();
        }
        RLock lock = null;
        try {
            if (null != redissonClient) {
                lock = redissonClient.getLock(key);
            }
        } catch (Exception e) {
            msg = "获取指定Key的分布式锁出现系统异常";
            logger.error(msg, e);
            throw new IllegalStateException(msg);
        }
        return lock;
    }

    /**
     * 锁住指定Key(默认)
     * 
     * @param key
     *            key字符串
     */
    public static void lock(String key) {
        lock(key, 60, 300, TimeUnit.SECONDS);
    }

    /**
     * 锁住指定Key(自定义锁的超时和失效时间)
     * 
     * @param key
     *            指定的Key
     * @param waitTime
     *            尝试锁住指定Key超时时间
     * @param leaseTime
     *            锁失效时间
     * @param unit
     *            时间单位
     */
    public static void lock(String key, long waitTime, long leaseTime, TimeUnit unit) {
        RLock lock = getLock(key);
        if (null == lock) {
            logger.error(GET_RLOCK_BY_KEY_ERROR);
            throw new IllegalStateException(GET_RLOCK_BY_KEY_ERROR);
        }
        Boolean isLocked = null;
        try {
            isLocked = lock.tryLock(waitTime, leaseTime, unit);
        } catch (InterruptedException e) {
            logger.error(TRY_TO_LOCK_KEY_RLOCK_ERROR, e);
            throw new IllegalStateException(TRY_TO_LOCK_KEY_RLOCK_ERROR);
        }
        if (null == isLocked) {
            logger.error(TRY_TO_LOCK_KEY_RLOCK_ERROR);
            throw new IllegalStateException(TRY_TO_LOCK_KEY_RLOCK_ERROR);
        }
        if (!isLocked) {
            logger.error(RLOCK_TIMEOUT_ERROR);
            throw new IllegalStateException(RLOCK_TIMEOUT_ERROR);
        }
        logger.debug("tryLock ===> lock :" + JsonUtils.toJsonStringWithDateFormat(lock));
        List<RLock> lockList = getRLockList();
        if (ObjectUtils.isNullOrEmpty(lockList)) {
            lockList = new ArrayList<RLock>();
        }
        lockList.add(lock);
        RLOCKLISTTHREADLOCAL.set(lockList);
    }

    /**
     * 解锁
     */
    public static void unlock() {
        String msg = null;
        try {
            List<RLock> lockList = getRLockList();
            if (!ObjectUtils.isNullOrEmpty(lockList)) {
                // 反序解锁
                for (int index = lockList.size() - 1; index >= 0; index--) {
                    RLock lock = lockList.get(index);
                    logger.debug("unlock ===> lock :" + JsonUtils.toJsonStringWithDateFormat(lock));
                    if (null != lock) {
                        logger.debug("unlock ===> lock.isLocked :" + lock.isLocked());
                        lock.unlock();
                    }
                }
            }
        } catch (Exception e) {
            msg = "释放指定Key的分布式锁出现系统异常";
            logger.error(msg);
            throw new IllegalStateException(msg);
        } finally {
            removeRLockList();
        }
    }

}
