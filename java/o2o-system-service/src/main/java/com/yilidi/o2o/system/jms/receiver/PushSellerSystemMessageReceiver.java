package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.model.PushSystemMessageModel;
import com.yilidi.o2o.system.message.IPushService;

/**
 * 推送消息接收者(卖家系统消息)
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:21:53
 */
public class PushSellerSystemMessageReceiver extends AbstractReceiver {

    @Autowired
    private IPushService pushService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        PushSystemMessageModel push = (PushSystemMessageModel) jmsMessageModel;
        pushService.sendSellerPushSystemMessage(push);
    }

}
