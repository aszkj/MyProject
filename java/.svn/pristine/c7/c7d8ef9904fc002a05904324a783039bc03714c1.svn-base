package com.yilidi.o2o.system.jms.receiver;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.system.proxy.crossdomain.model.UpdateSysParamRollbackMsgModel;

/**
 * 修改系统参数回滚消息接收者(供测试跨域事务功能使用，功能OK后应删除)
 * 
 * @author chenl
 * 
 */
public class UpdateSysParamRollbackMessageReceiver extends AbstractReceiver {

	@Override
	public void doReceive(JmsMessageModel jmsMessageModel) throws MessageException {
		UpdateSysParamRollbackMsgModel updateSysParamRollbackMsgModel = (UpdateSysParamRollbackMsgModel) jmsMessageModel;
		messageBusinessHandleAdapterService.rollbackUpdateSysParam(updateSysParamRollbackMsgModel);
	}

}
