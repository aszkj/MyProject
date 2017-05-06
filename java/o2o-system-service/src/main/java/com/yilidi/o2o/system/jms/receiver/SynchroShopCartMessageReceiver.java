package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.order.proxy.IShopCartProxyService;
import com.yilidi.o2o.system.jms.model.normal.SynchroShopCartListMessageModel;

/**
 * 同步购物车商品列表消息接收者
 * 
 * @author chenb
 * 
 */
public class SynchroShopCartMessageReceiver extends AbstractReceiver {

    @Autowired
    private IShopCartProxyService shopCartProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        SynchroShopCartListMessageModel synchroShopCartListMessageModel = (SynchroShopCartListMessageModel) jmsMessageModel;
        shopCartProxyService.synchronousCart(synchroShopCartListMessageModel.getUserId(),
                synchroShopCartListMessageModel.getShopCartProxyDtoList());
    }

}
