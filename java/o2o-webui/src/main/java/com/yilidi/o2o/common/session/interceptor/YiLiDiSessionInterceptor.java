package com.yilidi.o2o.common.session.interceptor;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.AsyncHandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.common.session.BaseSession;
import com.yilidi.o2o.common.session.generator.YiLiDiSessionGenerator;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.ReqAndRespAndSessionModel;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.CookieUtils;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * YiLiDiSession拦截器
 * 
 * @author chenl
 * 
 */
public class YiLiDiSessionInterceptor extends BaseSession implements AsyncHandlerInterceptor {

    private Logger logger = Logger.getLogger(YiLiDiSessionInterceptor.class);

    @Autowired
    private YiLiDiSessionGenerator yilidiSessionGenerator;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Jedis jedis = null;
        try {
            logger.debug("---------------------进入到YiLiDiSessionInterceptor拦截器的preHandle方法---------------------");
            String yiLiDiSessionID = null;
            YiLiDiSession session = null;
            yiLiDiSessionID = CookieUtils.getCookieValue(request, YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME, false);
            jedis = JedisUtils.getJedis();
            if (StringUtils.isEmpty(yiLiDiSessionID)) {
                session = yilidiSessionGenerator.createSession(request, response);
                logger.info("Cookie不存在，新建Session============================> session : "
                        + JsonUtils.toJsonStringWithDateFormat(session));
            } else {
                if (!jedis.hexists(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), yiLiDiSessionID.getBytes())) {
                    logger.info("Redis不存在================>YiLiDiSessionID : " + yiLiDiSessionID);
                    CookieUtils.deleteCookie(request, response, YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME);
                    session = yilidiSessionGenerator.createSession(request, response);
                    logger.info("Redis的Session缓存不存在，新建Session============================> session : "
                            + JsonUtils.toJsonStringWithDateFormat(session));
                } else {
                    byte[] sessionByteArray = jedis.hget(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(),
                            yiLiDiSessionID.getBytes());
                    if (!ObjectUtils.isNullOrEmpty(sessionByteArray)) {
                        session = (YiLiDiSession) SerializableUtils.read(sessionByteArray);
                        Date currentDate = new Date();
                        Date lastAccessedTime = session.getLastAccessedTime();
                        Integer maxInactiveInterval = session.getMaxInactiveInterval();
                        if (maxInactiveInterval.intValue() >= 0) {
                            if (currentDate.getTime() - lastAccessedTime.getTime() > maxInactiveInterval * 1000) {
                                CookieUtils.deleteCookie(request, response, YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME);
                                jedis.hdel(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), yiLiDiSessionID.getBytes());
                                logger.info("重建前================>YiLiDiSessionID : " + yiLiDiSessionID);
                                session = yilidiSessionGenerator.createSession(request, response);
                                logger.info("Session超时，重建Session============================> session : "
                                        + JsonUtils.toJsonStringWithDateFormat(session));
                                yiLiDiSessionID = CookieUtils.getCookieValue(request,
                                        YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME, false);
                                logger.info("重建后================>YiLiDiSessionID : " + yiLiDiSessionID
                                        + "，设置的Cookie没有通过浏览器，不会立即生效");
                            } else {
                                session.setLastAccessedTime(currentDate);
                                jedis.hset(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), yiLiDiSessionID.getBytes(),
                                        SerializableUtils.write(session));
                                logger.info("更新Session");
                            }
                        } else {
                            session.setLastAccessedTime(currentDate);
                            jedis.hset(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), yiLiDiSessionID.getBytes(),
                                    SerializableUtils.write(session));
                            logger.info("更新Session");
                        }
                    }
                }
            }
            ReqAndRespAndSessionModel model = new ReqAndRespAndSessionModel();
            model.setRequest(request);
            model.setResponse(response);
            model.setSession(session);
            REQANDRESPANDSESSIONMODELTHREADLOCAL.set(model);
            return true;
        } catch (Exception e) {
            logger.error("Session拦截器处理出现系统异常", e);
            throw new IllegalStateException("Session拦截器处理出现系统异常", e);
        } finally {
            if (null != jedis) {
                JedisUtils.returnResource(jedis);
            }
        }
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        logger.debug("---------------------进入到YiLiDiSessionInterceptor拦截器的postHandle方法---------------------");
        super.removeReqAndRespAndSessionModel();
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
        // TODO Auto-generated method stub

    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // TODO Auto-generated method stub

    }

}
