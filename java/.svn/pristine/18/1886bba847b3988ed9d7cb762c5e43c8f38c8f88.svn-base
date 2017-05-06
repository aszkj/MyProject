package com.yilidi.o2o.schedule.impl;

import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.schedule.ISessionTimeoutCheck;

/**
 * @Description: TODO(定时扫描过期的Session接口实现)
 * @author: chenlian
 * @date: 2016年5月30日 上午9:31:32
 */
public class SessionTimeoutCheck implements ISessionTimeoutCheck {

    private Logger logger = Logger.getLogger(SessionTimeoutCheck.class);

    @Override
    public void check() throws Exception {
        Jedis jedis = null;
        try {
            jedis = JedisUtils.getJedis();
            if (jedis.exists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes())) {
                logger.info("===============定时任务扫描过期的Session开始===============");
                Map<byte[], byte[]> map = jedis.hgetAll(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes());
                if (!ObjectUtils.isNullOrEmpty(map)) {
                    for (Map.Entry<byte[], byte[]> entry : map.entrySet()) {
                        byte[] key = entry.getKey();
                        byte[] value = entry.getValue();
                        YiLiDiSession session = (YiLiDiSession) SerializableUtils.read(value);
                        Date currentDate = new Date();
                        Date lastAccessedTime = session.getLastAccessedTime();
                        Integer maxInactiveInterval = session.getMaxInactiveInterval();
                        if (maxInactiveInterval.intValue() >= 0) {
                            if (currentDate.getTime() - lastAccessedTime.getTime() > maxInactiveInterval * 1000) {
                                logger.info("删除过期Session：============================> : "
                                        + JsonUtils.toJsonStringWithDateFormat(session));
                                jedis.hdel(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), key);
                            }
                        }
                    }
                }
                logger.info("===============定时任务扫描过期的Session结束===============");
            }
        } catch (Exception e) {
            String msg = "定时任务扫描过期的Session产生系统故障！";
            logger.error(msg, e);
            throw new IllegalStateException(msg);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }
}
