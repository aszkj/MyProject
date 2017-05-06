package com.yilidi.o2o.common.model;

/**
 * 
 * @Description:TODO(传到APP端数据统一封装类)
 * @author: chenlian
 * @date: 2015年12月15日 上午11:08:44
 * 
 */
public class AppMsgBean {
    private MsgCode msgCode;
    private String msg;
    private Object entity;

    public int getMsgCode() {
        switch (msgCode) {
        case FAILURE:// 失败
            return 0;
        case SUCCESS: // 成功
            return 1;
        case NO_LOGIN_OR_LOGIN_TIMEOUT: // 未登录或登录超时
            return 2;
        case MANDATORY_UPGRADE:
            return 3;// 强制升级

        default:
            return 0;
        }
    }

    public AppMsgBean setMsgCode(MsgCode msgCode) {
        this.msgCode = msgCode;
        return this;
    }

    public String getMsg() {
        return msg;
    }

    public AppMsgBean setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public enum MsgCode {
        FAILURE, SUCCESS, NO_LOGIN_OR_LOGIN_TIMEOUT, MANDATORY_UPGRADE;
    }

    public Object getEntity() {
        return entity;
    }

    public AppMsgBean setEntity(Object entity) {
        this.entity = entity;
        return this;
    }

    public static AppMsgBean getInstance() {
        return new AppMsgBean();
    }

}
