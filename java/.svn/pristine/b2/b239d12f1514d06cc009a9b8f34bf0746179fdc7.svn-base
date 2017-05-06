/**
 * 文件名称：IMessageBusinessHandleAdapterService.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.system.service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.proxy.crossdomain.model.SaveSysLogRollbackMsgModel;
import com.yilidi.o2o.system.proxy.crossdomain.model.UpdateSysParamRollbackMsgModel;

/**
 * 功能描述：消息业务处理适配服务类，每个Receiver在要调用其需事务控制的具体业务Service类时，都要先在这里定义接口，统一用该Service调用各个域的Service类的具体业务方法。 <br/>
 * 由于各域Service类业务方法成功执行后需调用YiLiDiMessageHandler的handleSuccess方法将异常消息记录清除掉，为了保证事务的一致性，并保证各域Service接口方法的非侵入性，
 * 定义了该适配接口对各域业务接口进行统一处理。 回滚子事务的接口方法以rollback*开头，便于统一明确管理及事务控制。
 * 
 * 
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IMessageBusinessHandleAdapterService {

	/**
	 * 回滚保存系统日志子事务
	 * 
	 * @param saveSysLogRollbackMsgModel
	 *            保存系统日志回滚消息接收的具体消息类型，其基类为JmsMessageModel
	 * @throws SystemServiceException
	 *             系统Service异常
	 */
	public void rollbackSaveSysLog(SaveSysLogRollbackMsgModel saveSysLogRollbackMsgModel) throws SystemServiceException;

	/**
	 * 回滚修改系统参数子事务
	 * 
	 * @param updateSysParamRollbackMsgModel
	 *            修改系统参数回滚消息接收的具体消息类型，其基类为JmsMessageModel
	 * @throws SystemServiceException
	 *             系统Service异常
	 */
	public void rollbackUpdateSysParam(UpdateSysParamRollbackMsgModel updateSysParamRollbackMsgModel)
			throws SystemServiceException;

}
