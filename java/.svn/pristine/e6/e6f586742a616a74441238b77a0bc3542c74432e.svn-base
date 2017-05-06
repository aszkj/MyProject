package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.system.model.ExceptionMessageInfo;

/**
 * 功能描述：异常消息信息数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ExceptionMessageInfoMapper {

	/**
	 * 保存异常消息信息
	 * 
	 * @param exceptionMessageInfo
	 * @return Integer
	 */
	Integer save(ExceptionMessageInfo exceptionMessageInfo);

	/**
	 * 根据异常JMS消息ID获取该异常消息信息
	 * 
	 * @param exceptionJmsMessageId
	 * @return ExceptionMessageInfo
	 */
	ExceptionMessageInfo loadByExceptionJmsMessageId(String exceptionJmsMessageId);

	/**
	 * 根据异常JMS消息ID更新该异常消息信息的重试次数
	 * 
	 * @param exceptionJmsMessageId
	 * @return Integer
	 */
	Integer updateRetryCountByExceptionJmsMessageId(String exceptionJmsMessageId);

	/**
	 * 根据异常JMS消息ID删除该异常消息信息
	 * 
	 * @param exceptionJmsMessageId
	 * @return Integer
	 */
	Integer deleteByExceptionJmsMessageId(String exceptionJmsMessageId);

	/**
	 * 获取需要定时任务处理的异常消息列表
	 * 
	 * @return List<ExceptionMessageInfo>
	 */
	List<ExceptionMessageInfo> listNeedScheduledHandleExceptionMessages();

}