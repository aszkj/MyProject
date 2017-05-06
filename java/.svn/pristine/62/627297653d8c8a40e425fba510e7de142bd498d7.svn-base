package com.yilidi.o2o.common.inteceptor.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.yilidi.o2o.common.annotation.BuyerLoginValidation;
import com.yilidi.o2o.common.exception.LoginStateException;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.sessionmodel.buyer.user.UserSessionModel;

/**
 * 买家登录拦截器
 * 
 * @author: chenlian
 * @date: 2016年5月28日 下午8:39:13
 */
public class BuyerLoginInterceptor extends HandlerInterceptorAdapter {

    private final Logger logger = Logger.getLogger(this.getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("------- 进入" + BuyerLoginInterceptor.class + "拦截器的preHandle函数 ---------");
        if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
            BuyerLoginValidation buyerLoginValidation = ((HandlerMethod) handler)
                    .getMethodAnnotation(BuyerLoginValidation.class);
            if (null == buyerLoginValidation || !buyerLoginValidation.validate()) {
                return true;
            } else {
                UserSessionModel buyerSessionModel = SessionUtils.getBuyerUserSession();
                if (null == buyerSessionModel) {
                    String msg = "未登录或登录超时";
                    logger.error(msg);
                    throw new LoginStateException(msg);
                }
                return true;
            }
        } else {
            return true;
        }
    }
}
