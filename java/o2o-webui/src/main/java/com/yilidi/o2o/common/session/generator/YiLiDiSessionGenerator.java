package com.yilidi.o2o.common.session.generator;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import redis.clients.jedis.Jedis;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.utils.JedisUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.CookieUtils;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

/**
 * YiLiDiSession生成器
 * 
 * @author chenl
 * 
 */
public class YiLiDiSessionGenerator {

	private Logger logger = Logger.getLogger(YiLiDiSessionGenerator.class);

	private ISystemParamsService systemParamsService;

	/**
	 * 创建自定义Session信息
	 * 
	 * @param request
	 *            网络请求
	 * @param response
	 *            网络应答
	 * @return 自定义Session信息
	 * @throws SystemServiceException
	 *             系统管理服务异常
	 */
	public YiLiDiSession createSession(HttpServletRequest request, HttpServletResponse response)
			throws SystemServiceException {
		Jedis jedis = null;
		try {
			jedis = JedisUtils.getJedis();
			String yilidiSessionID = StringUtils.getUUID(true);
			CookieUtils.setCookie(request, response, YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME, yilidiSessionID,
					3 * 60 * 60 * 24, false);
			YiLiDiSession session = new YiLiDiSession();
			session.setId(yilidiSessionID);
			session.setCreationTime(new Date());
			session.setLastAccessedTime(session.getCreationTime());
			String paramValue = SystemBasicDataUtils
					.getSystemParamValue(SystemContext.SystemParams.SESSION_MAX_INACTIVE_INTERVAL);
			if (!StringUtils.isEmpty(paramValue)) {
				session.setMaxInactiveInterval(new Integer(paramValue) * 60);
			} else {
				SystemParamsDto systemParamsDto = systemParamsService
						.loadByParamsCode(SystemContext.SystemParams.SESSION_MAX_INACTIVE_INTERVAL);
				if (null == systemParamsDto) {
					session.setMaxInactiveInterval(new Integer(20 * 60));
				} else {
					session.setMaxInactiveInterval(new Integer(systemParamsDto.getParamValue()) * 60);
				}
			}
			jedis.hset(YiLiDiSessionHolder.YILIDI_SESSION_KEY.getBytes(), yilidiSessionID.getBytes(),
					SerializableUtils.write(session));
			return session;
		} catch (Exception e) {
			String msg = "系统出现异常！";
			logger.error(msg, e);
			throw new SystemServiceException(msg, e);
		} finally {
			if (null != jedis) {
				JedisUtils.returnResource(jedis);
			}
		}
	}

	public ISystemParamsService getSystemParamsService() {
		return systemParamsService;
	}

	public void setSystemParamsService(ISystemParamsService systemParamsService) {
		this.systemParamsService = systemParamsService;
	}

}
