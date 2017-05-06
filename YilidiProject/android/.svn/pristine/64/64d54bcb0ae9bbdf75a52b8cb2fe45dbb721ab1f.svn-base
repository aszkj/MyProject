package com.yldbkd.www.library.android.bean;

import java.io.Serializable;

/**
 * 请求返回统一数据结构的数据
 * <p/>
 * Created by linghuxj on 15/10/8.
 */
public class MsgBean<T> implements Serializable {

    public static final int FAILURE = 0, SUCCESS = 1, NOLOGIN = 2, UPDATE = 3;

    /**
     * 请求返回的接口提示信息
     */
    private String msg;
    /**
     * 请求返回的类型
     * 0-失败
     * 1-成功
     * 2-未登录或登录过期
     * 3-强制升级
     */
    private Integer msgCode;
    /**
     * 返回需要的数据
     */
    private T entity;
    /**
     * 解密的私钥
     */
    private String key;

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getMsgCode() {
        return msgCode;
    }

    public void setMsgCode(Integer msgCode) {
        this.msgCode = msgCode;
    }

    public T getEntity() {
        return entity;
    }

    public void setEntity(T entity) {
        this.entity = entity;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
