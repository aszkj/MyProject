package com.yilidi.o2o.system.proxy.crossdomain;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.transaction.annotation.RollbackTransactionAnnotation;
import com.yilidi.o2o.system.proxy.dto.SystemLogProxyDto;

/**
 * 功能描述：systemLog跨域事务服务层接口 (供测试跨域事务功能使用，功能OK后应删除)<br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISystemLogCrossDomainProxyService {

	/**
	 * 保存系统日志
	 * 
	 * @param sysLog
	 *            系统日志对象
	 * @throws SystemServiceException
	 *             系统服务异常
	 * @return JmsMessageModel 消息参数基类
	 */
	@RollbackTransactionAnnotation(rollbackMessageProducerBeanName = "saveSysLogRollbackMessageSender")
	public JmsMessageModel saveLog(SystemLogProxyDto sysLog) throws SystemServiceException;

}
