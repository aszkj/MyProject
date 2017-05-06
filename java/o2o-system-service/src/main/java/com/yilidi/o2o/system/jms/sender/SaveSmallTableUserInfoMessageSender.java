package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 保存用户同步信息消息发送者
 * 
 * @author: chenlian
 * @date: 2016年8月12日 上午9:53:06
 */
public class SaveSmallTableUserInfoMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate saveSmallTableUserInfoTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        saveSmallTableUserInfoTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
