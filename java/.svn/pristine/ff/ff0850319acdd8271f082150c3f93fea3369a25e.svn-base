package com.yilidi.o2o.common.inteceptor.app;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.log4j.Logger;
import org.springframework.ui.ModelMap;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.context.request.WebRequestInterceptor;

import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;
import com.yilidi.o2o.common.utils.CookieUtils;
import com.yilidi.o2o.core.utils.DistributedLockUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * 
 * APP接口参数拦截器
 * 
 * @author: chenlian
 * @date: 2015年10月27日 下午2:28:53
 * 
 */
public class AppParameterInterceptor implements WebRequestInterceptor {

    private final Logger logger = Logger.getLogger(this.getClass());

    private String fixParamFromAppString(String paramFromApp) {
        return StringEscapeUtils.escapeJava(paramFromApp);
    }

    @Override
    public void preHandle(WebRequest request) throws Exception {
        logger.debug("------- 进入" + AppParameterInterceptor.class + "拦截器的preHandle函数 ---------");
        String appParamValidateMsg = null;
        AppParamModel appParamModel = null;
        try {
            boolean isMultipart = false;
            if (request instanceof ServletWebRequest) {
                ServletWebRequest webServlet = (ServletWebRequest) request;
                isMultipart = ServletFileUpload.isMultipartContent(webServlet.getRequest());
                String yiLiDiSessionID = CookieUtils.getCookieValue(webServlet.getRequest(),
                        YiLiDiSessionHolder.YILIDI_SESSIONID_COOKIENAME, false);
                logger.info("app interceptor yiLiDiSessionID:" + yiLiDiSessionID);
            }
            if (!isMultipart) {
                String paramFromApp = request.getParameter("param");
                if (StringUtils.isEmpty(paramFromApp)) {
                    appParamValidateMsg = "获取到的APP参数为空";
                    logger.error(appParamValidateMsg);
                    throw new IllegalArgumentException(appParamValidateMsg);
                }
                logger.info("============paramFromApp: " + fixParamFromAppString(paramFromApp));
                String paramFromAppWithBase64Decode = EncryptUtils.base64Decode(paramFromApp);
                logger.info("============paramFromAppWithBase64Decode : " + paramFromAppWithBase64Decode);
                appParamModel = JsonUtils.parseObject(paramFromAppWithBase64Decode, AppParamModel.class);
                logger.info("============versionCode : " + appParamModel.getVersionCode());
                logger.info("============intfCallChannel : " + appParamModel.getIntfCallChannel());
                logger.info("============key : " + appParamModel.getKey());
                logger.info("============deviceId : " + appParamModel.getDeviceId());
                logger.info("============entity : " + appParamModel.getEntity());
                request.setAttribute("deviceId", appParamModel.getDeviceId(), WebRequest.SCOPE_REQUEST);
                request.setAttribute("param", appParamModel, WebRequest.SCOPE_REQUEST);
            }
        } catch (Exception e) {
            if (StringUtils.isEmpty(appParamValidateMsg)) {
                appParamValidateMsg = "APP参数解析错误";
            }
            logger.error(appParamValidateMsg, e);
            throw new IllegalArgumentException(appParamValidateMsg);
        }
    }

    @Override
    public void postHandle(WebRequest request, ModelMap map) throws Exception {

    }

    @Override
    public void afterCompletion(WebRequest request, Exception exception) throws Exception {
        logger.debug("------- 进入" + AppParameterInterceptor.class + "拦截器的afterCompletion函数 ---------");
        DistributedLockUtils.unlock();
    }

}
