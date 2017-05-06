package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.order.proxy.IOrderProxyService;
import com.yilidi.o2o.system.jms.model.normal.UserRegistAwardMessageModel;

public class UserRegistAwardMessageReceiver extends AbstractReceiver{

	@Autowired
	private IOrderProxyService orderProxyService ;
	
	@Override
	public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
		UserRegistAwardMessageModel userShareAwardMessageModel = (UserRegistAwardMessageModel) jmsMessageModel;
		orderProxyService.sendUserRegistAward(userShareAwardMessageModel.getUserId(),userShareAwardMessageModel.getNowTime());
	}

}
