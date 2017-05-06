package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.system.jms.model.normal.UpdateUserAvatarMessageModel;
import com.yilidi.o2o.user.proxy.IUserProxyService;

/**
 * 修改用户头像消息
 * 
 * @author chenb
 * 
 */
public class UpdateUserAvatarMessageReceiver extends AbstractReceiver {

    @Autowired
    private IUserProxyService userProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        UpdateUserAvatarMessageModel updateUserAvatarMessageModel = (UpdateUserAvatarMessageModel) jmsMessageModel;
        userProxyService.updateUserAvatar(updateUserAvatarMessageModel.getUserId(),
                updateUserAvatarMessageModel.getUserAvatar());
    }

}
