package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 买赠赠送优惠券发送消息
 * 
 * @author chenb
 * 
 */
public class BuyRewardActivityMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate buyRewardActivityTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        buyRewardActivityTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
