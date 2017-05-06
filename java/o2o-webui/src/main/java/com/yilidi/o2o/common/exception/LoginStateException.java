package com.yilidi.o2o.common.exception;

/**
 * @Description: TODO(登录状态异常)
 * @author: chenlian
 * @date: 2016年5月28日 下午9:20:56
 */
public class LoginStateException extends RuntimeException {

    private static final long serialVersionUID = -7505274716728077572L;

    /**
     * 无参构造函数
     */
    public LoginStateException() {
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
    public LoginStateException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * 构造函数
     * 
     * @param message
     *            自定义异常信息
     */
    public LoginStateException(String message) {
        super(message);
    }

    /**
     * 构造函数
     * 
     * @param cause
     *            异常堆栈信息
     */
    public LoginStateException(Throwable cause) {
        super(cause);
    }

}
