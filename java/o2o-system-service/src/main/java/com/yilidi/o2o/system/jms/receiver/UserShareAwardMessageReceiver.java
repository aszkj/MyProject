package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.system.jms.model.normal.UserShareAwardMessageModel;
import com.yilidi.o2o.user.proxy.IUserShareProxyService;

/**
 * 登录日志消息记录
 * 
 * @author chenb
 * 
 */
public class UserShareAwardMessageReceiver extends AbstractReceiver {

    @Autowired
    private IUserShareProxyService userShareProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        UserShareAwardMessageModel userShareAwardMessageModel = (UserShareAwardMessageModel) jmsMessageModel;
        if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_LOGIN
                .equals(userShareAwardMessageModel.getAwardConditionType())) {
            userShareProxyService.saveUserShareAwardForLoginContidion(userShareAwardMessageModel.getUserId(),
                    userShareAwardMessageModel.getNowTime());
        }
        if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_PRODUCT
                .equals(userShareAwardMessageModel.getAwardConditionType())) {
            userShareProxyService.saveUserShareAwardForProductOrderContidion(userShareAwardMessageModel.getUserId(),
                    userShareAwardMessageModel.getNowTime(), userShareAwardMessageModel.getOrderNo());
        }
        if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_ANYORDER
                .equals(userShareAwardMessageModel.getAwardConditionType())) {
            userShareProxyService.saveUserShareAwardForAnyOrderContidion(userShareAwardMessageModel.getUserId(),
                    userShareAwardMessageModel.getNowTime(), userShareAwardMessageModel.getOrderNo());
        }
        if (SystemContext.UserDomain.SHARERULEINVITEDCONDITIONTYPE_REGISTER
                .equals(userShareAwardMessageModel.getAwardConditionType())) {
            userShareProxyService.saveUserShareAwardForRegisterContidion(userShareAwardMessageModel.getUserId(),
                    userShareAwardMessageModel.getNowTime());
        }
    }

}
