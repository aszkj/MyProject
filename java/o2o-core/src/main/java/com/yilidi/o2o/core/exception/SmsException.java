package com.yilidi.o2o.core.exception;

/**
 * 
 * @Description:TODO(短信异常)
 * @author: chenlian
 * @date: 2015年10月28日 下午7:46:02
 * 
 */
public class SmsException extends RuntimeException {

	private static final long serialVersionUID = 9204501516741336355L;

	/**
	 * 无参构造函数
	 */
	public SmsException() {
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
	public SmsException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            自定义异常信息
	 */
	public SmsException(String message) {
		super(message);
	}

	/**
	 * 构造函数
	 * 
	 * @param cause
	 *            异常堆栈信息
	 */
	public SmsException(Throwable cause) {
		super(cause);
	}

}
