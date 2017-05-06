package com.yilidi.o2o.common.inteceptor.app;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.yilidi.o2o.common.annotation.SellerLoginValidation;
import com.yilidi.o2o.common.exception.LoginStateException;
import com.yilidi.o2o.common.utils.SessionUtils;
import com.yilidi.o2o.sessionmodel.seller.user.SellerSessionModel;

/**
 * 卖家登录拦截器
 * 
 * @author: chenlian
 * @date: 2016年6月12日 上午9:06:41
 */
public class SellerLoginInterceptor extends HandlerInterceptorAdapter {

    private final Logger logger = Logger.getLogger(this.getClass());

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        logger.debug("------- 进入" + SellerLoginInterceptor.class + "拦截器的preHandle函数 ---------");
        if (handler.getClass().isAssignableFrom(HandlerMethod.class)) {
            SellerLoginValidation sellerLoginValidation = ((HandlerMethod) handler)
                    .getMethodAnnotation(SellerLoginValidation.class);
            if (null == sellerLoginValidation || !sellerLoginValidation.validate()) {
                return true;
            } else {
                SellerSessionModel sellerSessionModel = SessionUtils.getSellerUserSession();
                if (null == sellerSessionModel) {
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
