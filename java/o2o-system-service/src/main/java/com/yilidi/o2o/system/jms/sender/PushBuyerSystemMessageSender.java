package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 推送消息发送者(系统消息推送)
 * 
 * @author: zhangkun
 * @date: 2017年3月31日 
 */
public class PushBuyerSystemMessageSender extends AbstractSender {

	@Autowired
    private JmsTemplate pushBuyerSystemMessageTopicSendJmsTemplate;
	
	@Override
	public void doSend(JmsMessageModel jmsMessageModel) {
		pushBuyerSystemMessageTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
	}

}