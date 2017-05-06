package com.yilidi.o2o.controller.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.rpc.RpcException;
import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.exception.LoginStateException;
import com.yilidi.o2o.common.exception.UpgradeStateException;
import com.yilidi.o2o.common.model.AppMsgBean;
import com.yilidi.o2o.common.model.AppMsgBean.MsgCode;
import com.yilidi.o2o.common.model.AppParamModel;
import com.yilidi.o2o.common.model.ResultParamModel;
import com.yilidi.o2o.core.model.BaseVO;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 
 * APP的Controller基类
 * 
 * @author: chenlian
 * @date: 2015年10月27日 下午6:31:03
 * 
 */
public class AppBaseController extends BaseController {

    private static final String RPC_EXCEPTION_TIPS = "系统正在维护中，请稍候.....";

    /**
     * 获取APP传给后端的参数
     * 
     * @param req
     *            http请求
     * @return AppParamModel APP参数对象
     */
    protected AppParamModel getParameter(HttpServletRequest req) {
        return (AppParamModel) req.getAttribute("param");
    }

    /**
     * 获取deviceId
     * 
     * @param req
     *            http请求
     * @return String 设备ID
     */
    protected String getDeviceId(HttpServletRequest req) {
        return this.getParameter(req).getDeviceId();
    }

    /**
     * 获取intfCallChannel
     * 
     * @param req
     *            http请求
     * @return String 接口渠道
     */
    protected String getIntfCallChannel(HttpServletRequest req) {
        return this.getParameter(req).getIntfCallChannel();
    }

    /**
     * 获取key
     * 
     * @param req
     *            http请求
     * @return String 自定义KEY
     */
    protected String getKey(HttpServletRequest req) {
        return this.getParameter(req).getKey();
    }

    /**
     * 获取versionCode
     * 
     * @param req
     *            http请求
     * @return Integer 版本编号
     */
    protected Integer getVersionCode(HttpServletRequest req) {
        return this.getParameter(req).getVersionCode();
    }

    /**
     * 获取APP传给后端的参数实体封装类实体
     * 
     * @param req
     *            http请求
     * @param clazz
     *            类定义
     * @return T 类实体
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    protected <T extends AppBaseParam> T getEntityParam(HttpServletRequest req, Class<T> clazz) {
        if (ObjectUtils.isNullOrEmpty(this.getParameter(req).getEntity())) {
            String msg = "";
            try {
                return clazz.newInstance();
            } catch (Exception e) {
                msg = "系统出现异常";
                throw new IllegalArgumentException(msg);
            }
        }
        T obj = JsonUtils.parseObject(this.getParameter(req).getEntity(), clazz);
        obj.validateParams();
        return obj;
    }

    private ResultParamModel makeResultParamModel(AppMsgBean appMsgBean) {
        ResultParamModel param = new ResultParamModel();
        String oriResultString = JsonUtils.toJsonStringWithDateFormat(appMsgBean);
        logger.info("============返回原始数据：" + oriResultString);
        param.setResult(EncryptUtils.base64Encode(oriResultString));
        return param;
    }

    /**
     * 封装返回参数
     * 
     * @param result
     *            返回结果对象
     * @param msgCode
     *            消息编码
     * @param msg
     *            消息内容
     * @return ResultParamModel 结果参数对象
     */
    protected ResultParamModel encapsulateParam(Object result, MsgCode msgCode, String msg) {
        AppMsgBean appMsgBean = new AppMsgBean();
        appMsgBean.setEntity(result);
        appMsgBean.setMsgCode(msgCode).setMsg(msg);
        return makeResultParamModel(appMsgBean);
    }

    /**
     * 封装返回参数
     * 
     * @param msgCode
     *            消息编码
     * @param msg
     *            消息内容
     * @return ResultParamModel 结果参数对象
     */
    protected ResultParamModel encapsulateParam(MsgCode msgCode, String msg) {
        AppMsgBean appMsgBean = new AppMsgBean();
        appMsgBean.setMsgCode(msgCode).setMsg(msg);
        return makeResultParamModel(appMsgBean);
    }

    /**
     * 封装返回参数，含分页信息
     * 
     * @param result
     *            返回结果对象
     * @param resultVOList
     *            结果列表
     * @param msgCode
     *            消息编码
     * @param msg
     *            消息内容
     * @return ResultParamModel 结果参数对象
     */
    protected <E extends BaseVO> ResultParamModel encapsulatePageParam(Object result, List<E> resultVOList, MsgCode msgCode,
            String msg) {
        AppMsgBean appMsgBean = new AppMsgBean();
        if (result instanceof YiLiDiPage<?>) {
            YiLiDiPage<?> yiLiDiPage = (YiLiDiPage<?>) result;
            appMsgBean.setEntity(YiLiDiPageUtils.encapsulatePageResultForApp(yiLiDiPage, resultVOList)).setMsgCode(msgCode)
                    .setMsg(msg);
        }
        return makeResultParamModel(appMsgBean);
    }

    /**
     * APP接口异常统一处理
     * 
     * @param request
     *            http请求
     * @param ex
     *            异常对象
     * @return ResultParamModel 结果参数对象
     */
    @ExceptionHandler(value = { Exception.class })
    @ResponseBody
    public ResultParamModel handleException(HttpServletRequest request, Exception ex) {
        String errorMsg = "系统出现异常";
        if (null != ex.getMessage()) {
            errorMsg = ex.getMessage();
        }
        logger.error(errorMsg, ex);
        if (ex instanceof LoginStateException) {
            return encapsulateParam(AppMsgBean.MsgCode.NO_LOGIN_OR_LOGIN_TIMEOUT, ex.getMessage());
        } else if (ex instanceof UpgradeStateException) {
            return encapsulateParam(AppMsgBean.MsgCode.MANDATORY_UPGRADE, ex.getMessage());
        } else if (ex instanceof RpcException) {
            return encapsulateParam(AppMsgBean.MsgCode.FAILURE, RPC_EXCEPTION_TIPS);
        } else {
            return encapsulateParam(AppMsgBean.MsgCode.FAILURE, errorMsg);
        }
    }

}
