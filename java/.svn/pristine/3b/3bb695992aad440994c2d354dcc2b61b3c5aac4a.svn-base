package com.yilidi.o2o.controller.common;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.common.model.MsgBean;
import com.yilidi.o2o.common.model.MsgBean.MsgCode;
import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidator;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 
 * Controller的基类
 * 
 * @author: chenlian
 * @date: 2015年10月27日 下午6:31:03
 * 
 */
public class BaseController {

    protected Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    protected SystemBasicDataInfoUtils systemBasicDataInfoUtils;

    /**
     * 
     * 页面参数验证
     * 
     * @param params
     *            参数
     */
    protected void validateParams(Param... params) {
        if (!ObjectUtils.isNullOrEmpty(params)) {
            String msg = null;
            for (Param param : params) {
                ParamValidateMessageBean mb = ParamValidator.validate(param);
                if (null != mb && mb.getMsgCode() == ParamValidateMessageBean.MsgCode.FAILURE.getValue().intValue()) {
                    msg = mb.getMsg();
                    break;
                }
            }
            if (!StringUtils.isEmpty(msg)) {
                throw new IllegalArgumentException(msg);
            }
        }
    }

    /**
     * 获取客户真实IP
     * 
     * @param req
     *            http请求
     * @return String 客户真实IP
     */
    protected String getRealIP(HttpServletRequest req) {
        // 客户端真实IP，之所以能获取到该真实IP，是因为在Nginx里配置了“proxy_set_header X-Real-IP $remote_addr
        return req.getHeader("X-Real-IP");
    }

    /**
     * 
     * 封装返回的MsgBean
     * 
     * @param result
     *            结果对象
     * @param msgCode
     *            消息编码
     * @param msg
     *            消息内容
     * @return MsgBean 消息实体
     */
    protected MsgBean encapsulateMsgBean(Object result, MsgCode msgCode, String msg) {
        MsgBean msgBean = new MsgBean();
        msgBean.setEntity(result).setMsgCode(msgCode).setMsg(msg);
        logger.debug("============返回原始数据：" + JsonUtils.toJsonStringWithDateFormat(msgBean));
        return msgBean;
    }

    /**
     * 
     * 封装返回的MsgBean
     * 
     * @param msgCode
     *            消息编码
     * @param msg
     *            消息内容
     * @return MsgBean 消息实体
     */
    protected MsgBean encapsulateMsgBean(MsgCode msgCode, String msg) {
        MsgBean msgBean = new MsgBean();
        msgBean.setMsgCode(msgCode).setMsg(msg);
        logger.debug("============返回无Entity原始数据：" + JsonUtils.toJsonStringWithDateFormat(msgBean));
        return msgBean;
    }

}
