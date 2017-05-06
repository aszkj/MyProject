package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 同步商品冗余库存字段消息发送者
 * 
 * @author chenb
 * 
 */
public class SynchroSaleProductRemainCountMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate synchroSaleProductRemainCountTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        synchroSaleProductRemainCountTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
