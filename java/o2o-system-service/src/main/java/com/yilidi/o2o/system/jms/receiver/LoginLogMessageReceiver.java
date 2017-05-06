package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.jms.model.normal.LoginLogMessageModel;
import com.yilidi.o2o.user.proxy.ILoginLogProxyService;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;

/**
 * 登录日志消息记录
 * 
 * @author chenb
 * 
 */
public class LoginLogMessageReceiver extends AbstractReceiver {

    @Autowired
    private ILoginLogProxyService loginLogProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        LoginLogMessageModel loginLogMessageModel = (LoginLogMessageModel) jmsMessageModel;
        LoginLogProxyDto loginLogProxyDto = new LoginLogProxyDto();
        ObjectUtils.fastCopy(loginLogMessageModel, loginLogProxyDto);
        if (null == loginLogProxyDto.getLogoutTime()) {
            loginLogProxyService.save(loginLogProxyDto);
        } else {
            loginLogProxyService.updateLogoutTimeBySessionId(loginLogProxyDto.getSessionId());
        }
    }

}
