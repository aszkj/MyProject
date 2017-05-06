package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 用户分享奖励消息
 * 
 * @author chenb
 * 
 */
public class UpdateUserAvatarMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate updateUserAvatarTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        updateUserAvatarTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
