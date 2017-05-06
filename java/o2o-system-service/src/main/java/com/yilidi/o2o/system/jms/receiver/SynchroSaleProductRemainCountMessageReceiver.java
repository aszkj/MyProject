package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.system.jms.model.normal.SynchroSaleProductRemainCountMessageModel;

/**
 * 同步商品冗余库存字段消息接收者
 * 
 * @author chenb
 * 
 */
public class SynchroSaleProductRemainCountMessageReceiver extends AbstractReceiver {

    @Autowired
    private IProductProxyService productProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        SynchroSaleProductRemainCountMessageModel synchroSaleProductRemainCountMessageModel = (SynchroSaleProductRemainCountMessageModel) jmsMessageModel;
        productProxyService.updateBatchSaleProductRemainCount(synchroSaleProductRemainCountMessageModel.getKeyValuePairs(),
                synchroSaleProductRemainCountMessageModel.getUserId());
    }

}
