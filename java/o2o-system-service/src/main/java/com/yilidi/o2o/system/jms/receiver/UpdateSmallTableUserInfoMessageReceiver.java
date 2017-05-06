package com.yilidi.o2o.system.jms.receiver;

import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.ISmallTableUserInfoProxyService;
import com.yilidi.o2o.system.jms.model.normal.SmallTableUserInfoMessageModel;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;

/**
 * 更新用户同步信息消息接收者
 * 
 * @author: chenlian
 * @date: 2016年8月12日 上午10:12:18
 */
public class UpdateSmallTableUserInfoMessageReceiver extends AbstractReceiver {

    @Autowired
    private ISmallTableUserInfoProxyService smallTableUserInfoProxyService;

    @Override
    public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
        SmallTableUserInfoMessageModel smallTableUserInfoMessageModel = (SmallTableUserInfoMessageModel) jmsMessageModel;
        SmallTableUserInfoProxyDto smallTableUserInfoProxyDto = new SmallTableUserInfoProxyDto();
        ObjectUtils.fastCopy(smallTableUserInfoMessageModel, smallTableUserInfoProxyDto);
        smallTableUserInfoProxyService.updateByUserId(smallTableUserInfoProxyDto);
    }

}
