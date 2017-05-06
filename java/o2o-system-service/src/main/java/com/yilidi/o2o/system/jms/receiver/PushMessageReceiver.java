package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.system.message.IPushService;

/**
 * 推送消息接收者
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:21:53
 */
public class PushMessageReceiver extends AbstractReceiver {

    @Autowired
    private IPushService pushService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        PushMessageModel push = (PushMessageModel) jmsMessageModel;
        pushService.sendPushOrderMessage(push);
    }

}
