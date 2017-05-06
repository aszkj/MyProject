package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.model.PushSystemMessageModel;
import com.yilidi.o2o.system.message.IPushService;

/**
 * 推送消息接收者(买家系统消息)
 * 
 * @author: 张坤
 * @date: 2017.3.31
 */
public class PushBuyerSystemMessageReceiver extends AbstractReceiver {

    @Autowired
    private IPushService pushService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        PushSystemMessageModel push = (PushSystemMessageModel) jmsMessageModel;
        pushService.sendBuyerPushSystemMessage(push);
    }

}
