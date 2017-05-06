package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 同步购物车商品列表消息发送者
 * 
 * @author chenb
 * 
 */
public class SynchroShopCartMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate synchroShopCartTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        synchroShopCartTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
