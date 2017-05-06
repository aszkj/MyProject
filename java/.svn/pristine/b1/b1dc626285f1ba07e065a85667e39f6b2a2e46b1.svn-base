package com.yilidi.o2o.common.inteceptor.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;

/**
 * 为防止重复提交或恶意刷接口，控制同一deviceId或同一IP串行调用同一接口原子操作的同步调用拦截器
 * 
 * @author: chenlian
 * @date: 2016年6月12日 上午9:06:41
 */
public class SynchronizeInvokeInterceptor extends HandlerInterceptorAdapter {

    private final Logger logger = Logger.getLogger(this.getClass());

    private static final String IP_SYNCHRONIZE_KEY = "IP_SYNCHRONIZE_KEY";

    private static final String DEVICEID_SYNCHRONIZE_KEY = "DEVICEID_SYNCHRONIZE_KEY";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("------- 进入" + SynchronizeInvokeInterceptor.class + "拦截器的preHandle函数 ---------");
        String deviceId = (String) request.getAttribute("deviceId");
        logger.info("deviceId : " + deviceId);
        String requestURI = request.getRequestURI();
        logger.info("requestURI : " + requestURI);
        String ip = request.getHeader("X-Real-IP");
        logger.info("ip : " + ip);
        // 先锁定设备，在获取不到deviceId的情况下，锁定IP
        if (!StringUtils.isEmpty(deviceId)) {
            DistributedLockUtils.lock(EncryptUtils.base64Encode(DEVICEID_SYNCHRONIZE_KEY + deviceId + requestURI));
        } else {
            if (!StringUtils.isEmpty(ip)) {
                DistributedLockUtils.lock(EncryptUtils.base64Encode(IP_SYNCHRONIZE_KEY + ip + requestURI));
            }
        }
        return true;
    }

}
