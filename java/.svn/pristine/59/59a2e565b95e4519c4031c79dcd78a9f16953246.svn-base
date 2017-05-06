package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 注册送发送消息
 * 
 * @author zhangkun
 * 
 */
public class UserRegistAwardMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate userRegistAwardTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        userRegistAwardTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
