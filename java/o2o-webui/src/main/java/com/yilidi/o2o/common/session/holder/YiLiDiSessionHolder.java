package com.yilidi.o2o.common.session.holder;

import org.apache.log4j.Logger;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.common.session.BaseSession;
import com.yilidi.o2o.common.session.generator.YiLiDiSessionGenerator;
import com.yilidi.o2o.common.session.model.ReqAndRespAndSessionModel;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.core.utils.JedisUtils;

/**
 * YiLiDiSessionHolder
 * 
 * @author chenl
 * 
 */
public final class YiLiDiSessionHolder extends BaseSession {

    private static final Logger LOGGER = Logger.getLogger(YiLiDiSessionHolder.class);
    /**
     * SessionID的cookie名称：YiLiDiSessionID
     */
    public static final String YILIDI_SESSIONID_COOKIENAME = "YiLiDiSessionID";
    /**
     * Session在redis里面存放的Key：YiLiDiSessionKey
     */
    public static final String YILIDI_SESSION_KEY = "YiLiDiSessionKey";
    /**
     * YiLiDiSessionHolder在Spring配置文件里配置的bean name
     */
    public static final String YILIDI_SESSION_GENERATOR_BEAN_NAME = "yilidiSessionGenerator";

    private YiLiDiSessionHolder() {
    };

    /**
     * 获取自定义Session信息
     * 
     * @return 自定义Session信息
     */
    public static YiLiDiSession getSession() {
        return getSession(true);
    }

    /**
     * 获取自定义Session信息
     * 
     * @param whetherOrNotCreateSession
     *            是否创建新session
     * @return 自定义Session信息
     */
    public static YiLiDiSession getSession(boolean whetherOrNotCreateSession) {
        Jedis jedis = null;
        try {
            jedis = JedisUtils.getJedis();
            ReqAndRespAndSessionModel model = getReqAndRespAndSessionModel();
            if (null == model || null == model.getRequest() || null == model.getResponse()) {
                return null;
            }
            if (null != model.getSession() && null != model.getSession().getId()) {
                return model.getSession();
            } else {
                if (whetherOrNotCreateSession) {
                    WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                    YiLiDiSessionGenerator yilidiSessionGenerator = (YiLiDiSessionGenerator) wac
                            .getBean(YILIDI_SESSION_GENERATOR_BEAN_NAME);
                    YiLiDiSession session = yilidiSessionGenerator.createSession(model.getRequest(), model.getResponse());
                    model.setSession(session);
                    REQANDRESPANDSESSIONMODELTHREADLOCAL.set(model);
                    return session;
                } else {
                    return null;
                }
            }
        } catch (Exception e) {
            String msg = "系统出现异常！";
            LOGGER.error(msg, e);
            return null;
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }
}
