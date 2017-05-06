package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 修改系统参数回滚消息发送者(供测试跨域事务功能使用，功能OK后应删除)
 * 
 * @author chenl
 * 
 */
public class UpdateSysParamRollbackMessageSender extends AbstractSender {

	@Autowired
	private JmsTemplate updateSysParamRollbackTopicSendJmsTemplate;

	@Override
	public void doSend(JmsMessageModel jmsMessageModel) {
		updateSysParamRollbackTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
	}

}
