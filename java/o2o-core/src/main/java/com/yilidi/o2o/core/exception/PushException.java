package com.yilidi.o2o.core.exception;

/**
 * 推送异常
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午6:25:50
 */
public class PushException extends RuntimeException {

    private static final long serialVersionUID = 9204501516741336355L;

    /**
     * 无参构造函数
     */
    public PushException() {
        super();
    }

    /**
     * 构造函数
     * 
     * @param message
     *            自定义异常信息
     * @param cause
     *            异常堆栈信息
     */
    public PushException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * 构造函数
     * 
     * @param message
     *            自定义异常信息
     */
    public PushException(String message) {
        super(message);
    }

    /**
     * 构造函数
     * 
     * @param cause
     *            异常堆栈信息
     */
    public PushException(Throwable cause) {
        super(cause);
    }

}
