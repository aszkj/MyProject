package com.yilidi.o2o.system.proxy.crossdomain;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.transaction.annotation.RollbackTransactionAnnotation;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;

/**
 * 功能描述：systemParams跨域事务服务层接口 (供测试跨域事务功能使用，功能OK后应删除)<br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISystemParamsCrossDomainProxyService {

	/**
	 * 修改系统参数
	 * 
	 * @param systemParamsProxyDto
	 *            系统参数对象
	 * @throws SystemServiceException
	 *             系统服务异常
	 * @return JmsMessageModel 消息参数基类
	 */
	@RollbackTransactionAnnotation(rollbackMessageProducerBeanName = "updateSysParamRollbackMessageSender")
	public JmsMessageModel updateSystemParam(SystemParamsProxyDto systemParamsProxyDto) throws SystemServiceException;

}
