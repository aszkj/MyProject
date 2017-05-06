package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.system.message.ISmsService;

/**
 * 功能描述：短信消息接收者 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SmsMessageReceiver extends AbstractReceiver {

	@Autowired
	private ISmsService smsService;

	@Override
	public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
		SmsMessageModel sms = (SmsMessageModel) jmsMessageModel;
		smsService.sendSms(sms);
	}

}
