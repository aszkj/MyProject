/**
 * 文件名称：ServerLevelException.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.exception;

/**
 * 功能描述：服务层异常类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ServiceLevelException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	/**
	 * 无参构造函数
	 */
	public ServiceLevelException() {
		super();
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            设置的异常信息
	 * @param cause
	 *            异常描述待堆栈信息
	 */
	public ServiceLevelException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            异常信息
	 */
	public ServiceLevelException(String message) {
		super(message);
	}

	/**
	 * 构造函数
	 * 
	 * @param cause
	 *            异常
	 */
	public ServiceLevelException(Throwable cause) {
		super(cause);
	}

}
