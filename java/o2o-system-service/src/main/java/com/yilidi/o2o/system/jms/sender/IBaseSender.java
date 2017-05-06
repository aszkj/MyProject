package com.yilidi.o2o.system.jms.sender;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 消息发送者接口
 * 
 * @author chenl
 * 
 */
public interface IBaseSender {

	public void sendMessage(JmsMessageModel jmsMessageModel) throws MessageException;

}
