package com.yilidi.o2o.system.jms.receiver;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.system.jms.model.normal.BuyRewardActivityMessageModel;

public class BuyRewardActivityMessageReceiver extends AbstractReceiver {

    @Autowired
    private ICouponProxyService couponProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        BuyRewardActivityMessageModel buyRewardActivityMessageModel = (BuyRewardActivityMessageModel) jmsMessageModel;
        if (buyRewardActivityMessageModel.getNowTime() == null) {
            buyRewardActivityMessageModel.setNowTime(new Date());
        }
        couponProxyService.saveBuyRewardActivity(buyRewardActivityMessageModel.getOrderNo(),
                buyRewardActivityMessageModel.getOperationUserId(), buyRewardActivityMessageModel.getNowTime());
    }

}
