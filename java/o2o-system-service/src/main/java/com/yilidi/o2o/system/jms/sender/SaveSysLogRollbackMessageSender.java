package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 保存系统日志回滚消息发送者(供测试跨域事务功能使用，功能OK后应删除)
 * 
 * @author chenl
 *
 */
public class SaveSysLogRollbackMessageSender extends AbstractSender {
	
	@Autowired
	private JmsTemplate saveSysLogRollbackTopicSendJmsTemplate;

	@Override
	public void doSend(JmsMessageModel jmsMessageModel) {
		saveSysLogRollbackTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
	}

}
