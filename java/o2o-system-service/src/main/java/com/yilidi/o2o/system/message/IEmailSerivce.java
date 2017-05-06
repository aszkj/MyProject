/**
 * 文件名称：IEmailSerivce.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.message;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.EmailMessageModel;

/**
 * 功能描述：邮件服务接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IEmailSerivce {
	/**
	 * 发送邮件
	 * 
	 * @param email
	 *            邮件实体
	 * @throws MessageException
	 *             异常
	 */
	public void sendEmail(EmailMessageModel email) throws MessageException;
}
