/**
 * 文件名称：MessageException.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.exception;

/**
 * 功能描述：消息异常类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class MessageException extends RuntimeException {

	private static final long serialVersionUID = 9204501516741336355L;

	/**
	 * 无参构造函数
	 */
	public MessageException() {
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
	public MessageException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构造函数
	 * 
	 * @param message
	 *            自定义异常信息
	 */
	public MessageException(String message) {
		super(message);
	}

	/**
	 * 构造函数
	 * 
	 * @param cause
	 *            异常堆栈信息
	 */
	public MessageException(Throwable cause) {
		super(cause);
	}

}
