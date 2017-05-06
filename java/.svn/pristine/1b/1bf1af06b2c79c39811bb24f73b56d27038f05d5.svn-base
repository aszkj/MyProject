package com.yilidi.o2o.system.service;

import java.util.List;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.ExceptionMessageInfoDto;
import com.yilidi.o2o.system.service.dto.ExceptionMessageManualHandlingDto;
import com.yilidi.o2o.system.service.dto.query.ExceptionMessageManualHandlingQuery;

/**
 * 功能描述：消息服务类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IExceptionMessageOperationService {

    /**
     * 根据exceptionJmsMessageId获取异常消息信息
     * 
     * @param exceptionJmsMessageId
     * @return ExceptionMessageInfoDto
     * @throws SystemServiceException
     */
    public ExceptionMessageInfoDto loadExceptionMessageInfo(String exceptionJmsMessageId) throws SystemServiceException;

    /**
     * 根据异常JMS消息ID获取该异常消息信息
     * 
     * @param exceptionJmsMessageId
     * @throws SystemServiceException
     */
    public void updateRetryCountByExceptionJmsMessageId(String exceptionJmsMessageId) throws SystemServiceException;

    /**
     * 根据异常JMS消息ID删除该异常消息信息
     * 
     * @param exceptionJmsMessageId
     * @throws SystemServiceException
     */
    public void deleteExceptionMessageInfo(String exceptionJmsMessageId) throws SystemServiceException;

    /**
     * 根据ExceptionMessageManualHandling的Id获取异常消息人工处理信息
     * 
     * @param exceptionMessageManualHandlingId
     * @return ExceptionMessageManualHandlingDto
     * @throws SystemServiceException
     */
    public ExceptionMessageManualHandlingDto loadExceptionMessageManualHandling(Integer exceptionMessageManualHandlingId)
            throws SystemServiceException;

    /**
     * 根据ExceptionMessageManualHandling的Id删除该异常消息人工处理信息
     * 
     * @param exceptionMessageManualHandlingId
     * @throws SystemServiceException
     */
    public void deleteExceptionMessageManualHandling(Integer exceptionMessageManualHandlingId) throws SystemServiceException;

    /**
     * 保存异常消息信息
     * 
     * @param exceptionMessageInfoDto
     * @throws SystemServiceException
     */
    public void saveExceptionMessageInfo(ExceptionMessageInfoDto exceptionMessageInfoDto) throws SystemServiceException;

    /**
     * 保存异常消息人工处理信息
     * 
     * @param exceptionMessageManualHandlingDto
     * @throws SystemServiceException
     */
    public void saveExceptionMessageManualHandling(ExceptionMessageManualHandlingDto exceptionMessageManualHandlingDto)
            throws SystemServiceException;

    /**
     * 保存来源于异常消息记录的异常消息人工处理信息
     * 
     * @param exceptionJmsMessageId
     * @throws SystemServiceException
     */
    public void saveExceptionMessageManualHandlingFromExceptionMessageInfo(String exceptionJmsMessageId)
            throws SystemServiceException;

    /**
     * 获取需要定时任务处理的异常消息列表
     * 
     * @return List<ExceptionMessageInfoDto>
     * @throws SystemServiceException
     */
    public List<ExceptionMessageInfoDto> listNeedScheduledHandleExceptionMessages() throws SystemServiceException;

    /**
     * 分页显示需要人工处理的异常消息
     * 
     * @param query
     * @return Page<ExceptionMessageManualHandlingDto>
     * @throws SystemServiceException
     */
    public Page<ExceptionMessageManualHandlingDto> findExceptionMessageManualHandlings(
            ExceptionMessageManualHandlingQuery query) throws SystemServiceException;

    /**
     * 通过定时任务再次发送之前产生异常的消息（每10分钟执行一次，发送S_EXCEPTION_MESSAGE_INFO表里，离当前时间10分钟之前的消息记录）
     * 
     * @param exceptionJmsMessageId
     * @throws MessageException
     */
    public void sendMessageForScheduled(String exceptionJmsMessageId) throws MessageException;

    /**
     * 人工通过点击“异常消息列表页面”的“发送”链接，手动发送消息
     * 
     * @param exceptionMessageManualHandlingId
     * @throws MessageException
     */
    public void sendMessageForManual(Integer exceptionMessageManualHandlingId) throws MessageException;

}
