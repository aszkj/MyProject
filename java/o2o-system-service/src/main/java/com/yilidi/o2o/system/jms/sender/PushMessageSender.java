package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 推送消息发送者
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:20:06
 */
public class PushMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate pushTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        pushTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
