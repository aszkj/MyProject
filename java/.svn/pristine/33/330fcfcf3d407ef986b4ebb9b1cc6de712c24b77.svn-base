package com.yilidi.o2o.schedule.system;

import java.util.List;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.service.IExceptionMessageOperationService;
import com.yilidi.o2o.system.service.dto.ExceptionMessageInfoDto;

/**
 * 异常消息重发定时任务（用于定时扫描S_EXCEPTION_MESSAGE_INFO表里未被成功消费的消息记录进行重发）
 * 
 * 利用ScheduledThreadPoolExecutor进行重发时，如果一直异常且没有达到重发的最大阈值，如果这时服务器Down机了，则后续的重发会终止，因此有必要还需用Spring
 * quartz定时任务来定时扫描S_EXCEPTION_MESSAGE_INFO表里残留的未重发完的纪录
 * 
 * 为了防止用Spring quartz定时任务发送的异常信息正在使用ScheduledThreadPoolExecutor进行重发中，这里每次扫描的都是前10分钟之前S_EXCEPTION_MESSAGE_INFO表里未被成功消费的消息记录
 * 
 * @author chenl
 * 
 */
public class ExceptionMessageRetySendJob {

    private Logger logger = Logger.getLogger(ExceptionMessageRetySendJob.class);

    private IExceptionMessageOperationService exceptionMessageOperationService;

    protected synchronized void performance() {
        try {
            List<ExceptionMessageInfoDto> exceptionMessageInfoDtoList = exceptionMessageOperationService
                    .listNeedScheduledHandleExceptionMessages();
            if (!ObjectUtils.isNullOrEmpty(exceptionMessageInfoDtoList)) {
                logger.info("===============异常消息重发开始===============");
                for (ExceptionMessageInfoDto exceptionMessageInfoDto : exceptionMessageInfoDtoList) {
                    try {
                        exceptionMessageOperationService.sendMessageForScheduled(exceptionMessageInfoDto
                                .getExceptionJmsMessageId());
                    } catch (MessageException e) {
                        logger.error(e.getMessage());
                    }
                }
                logger.info("===============异常消息重发结束===============");
            }
        } catch (Exception e) {
            logger.error("异常消息重发产生系统故障！", e);
        }
    }

    public IExceptionMessageOperationService getExceptionMessageOperationService() {
        return exceptionMessageOperationService;
    }

    public void setExceptionMessageOperationService(IExceptionMessageOperationService exceptionMessageOperationService) {
        this.exceptionMessageOperationService = exceptionMessageOperationService;
    }

}
