package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.EmailMessageModel;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.system.message.IEmailSerivce;

/**
 * 功能描述：邮件消息接收者 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class EmailMessageReceiver extends AbstractReceiver {

	@Autowired
	private IEmailSerivce emailService;

	@Override
	public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
		EmailMessageModel email = (EmailMessageModel) jmsMessageModel;
		emailService.sendEmail(email);
	}

}
