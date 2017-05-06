package com.yilidi.o2o.system.jms.handler;

import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.alibaba.druid.util.StringUtils;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.jms.sender.IBaseSender;
import com.yilidi.o2o.system.service.IExceptionMessageOperationService;
import com.yilidi.o2o.system.service.dto.ExceptionMessageInfoDto;
import com.yilidi.o2o.system.service.dto.ExceptionMessageManualHandlingDto;

/**
 * 消息处理Handler
 * 
 * 功能描述：用于处理消息，在确保幂等性操作的前提下，自定义消息重发，并在重发无果的情况下，将消息记录下来，人工处理触发消息。 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class YiLiDiMessageHandler {

    private Logger logger = Logger.getLogger(YiLiDiMessageHandler.class);

    private IExceptionMessageOperationService exceptionMessageOperationService;

    /**
     * 验证消息业务是否应该被处理，保证消息的幂等性，即多次消费重发的消息，只被正确处理一次，相当于一次处理的结果。
     * 对于同一个Receiver来说，它是按顺序串行消费消息的，也就是说，第一个消息的onMessage方法执行完毕，才会开始消费第二个消息并再次进入onMessage方法执行业务逻辑，
     * 因此不用担心出现由于消费处理业务耗时过长而同时处理针对某个异常消息的多次重发消息所带来的消费成功与否的不确定性情况，故该方法可以保证消息的幂等性。
     * 
     * @param JMSMessageID
     *            JMS消息ID，有可能是新消息的JMSMessageID，也有可能是之前异常消息的exceptionJmsMessageId
     * @param jmsMessageModel
     *            消息的具体实体实例
     * @return Boolean 是否应该被处理
     */
    public Boolean validateWhetherOrNotShouldHandleMessage(String JMSMessageID, JmsMessageModel jmsMessageModel) {
        try {
            if (null == JMSMessageID) {
                String str = "参数JMSMessageID不能为空";
                throw new MessageException(str);
            }
            ExceptionMessageInfoDto exceptionMessageInfoDto = exceptionMessageOperationService
                    .loadExceptionMessageInfo(JMSMessageID);
            // 异常消息信息表里有该条记录，表示该消息还没被正确处理过，该次消费可以继续处理
            if (null != exceptionMessageInfoDto) {
                return true;
            }
            // 异常消息信息表里没有该条记录，表示该消息要么是第一发送的新消息，要么是之前重发过并被正确处理过的消息，要么是存在于人工处理表里的进行人工触发的信息
            else {
                Integer exceptionMessageManualHandlingId = jmsMessageModel.getExceptionMessageManualHandlingId();
                if (null == exceptionMessageManualHandlingId) {
                    // 第一发送的新消息
                    if (StringUtils.isEmpty(jmsMessageModel.getExceptionJmsMessageId())) {
                        return true;
                    }
                    // 之前重发过并被正确处理过的消息
                    else {
                        return false;
                    }
                }
                // 存在于人工处理表里的进行人工触发的信息
                else {
                    return true;
                }
            }
        } catch (Exception e) {
            logger.error(e);
            return false;
        }
    }

    /**
     * 消费消息发生异常时的处理
     * 
     * @param messageName
     *            消息名称
     * @param exceptionJmsMessageId
     *            异常JMS消息ID
     * @param producerClassName
     *            消息生产者所属的实体模型类的全名
     * @param parameterClassName
     *            发送的消息参数所属的实体模型类的全名
     * @param jmsMessageModel
     *            消息的具体实体实例
     * @param maxRetryThreshold
     *            最大的重试阈值
     * @param intervalTime
     *            消息重发时间间隔
     */
    public void handleReceiverException(String messageName, String exceptionJmsMessageId, String producerClassName,
            String parameterClassName, JmsMessageModel jmsMessageModel, Integer maxRetryThreshold, Integer intervalTime)
            throws MessageException {
        String str = null;
        if (StringUtils.isEmpty(messageName)) {
            str = "参数messageName不能为空";
            throw new MessageException(str);
        }
        if (StringUtils.isEmpty(exceptionJmsMessageId)) {
            str = "参数exceptionJmsMessageId不能为空";
            throw new MessageException(str);
        }
        if (StringUtils.isEmpty(producerClassName)) {
            str = "参数producerClassName不能为空";
            throw new MessageException(str);
        }
        if (StringUtils.isEmpty(parameterClassName)) {
            str = "参数parameterClassName不能为空";
            throw new MessageException(str);
        }
        if (null == jmsMessageModel) {
            str = "参数jmsMessageModel不能为空";
            throw new MessageException(str);
        }
        if (null == maxRetryThreshold) {
            str = "参数maxRetryThreshold不能为空";
            throw new MessageException(str);
        }
        if (null == intervalTime) {
            str = "参数intervalTime不能为空";
            throw new MessageException(str);
        }
        Integer exceptionMessageManualHandlingId = jmsMessageModel.getExceptionMessageManualHandlingId();
        // 如果为“人工触发 ”，消费消息发生异常时，不做任何事情，由人工定位好问题并处理完毕后，再手动触发消息
        if (null != exceptionMessageManualHandlingId) {
            logger.error("=======================================>exceptionMessageManualHandlingId : "
                    + exceptionMessageManualHandlingId);
            return;
        } else {
            this.retry(messageName, exceptionJmsMessageId, producerClassName, jmsMessageModel, parameterClassName,
                    maxRetryThreshold, intervalTime);
        }
    }

    private void retry(final String messageName, String exceptionJmsMessageId, final String producerClassName,
            final JmsMessageModel jmsMessageModel, final String parameterClassName, Integer maxRetryThreshold,
            Integer intervalTime) throws MessageException {
        ExceptionMessageInfoDto exceptionMessageInfoDto = null;
        try {
            if (StringUtils.isEmpty(jmsMessageModel.getExceptionJmsMessageId())) {
                jmsMessageModel.setExceptionJmsMessageId(exceptionJmsMessageId);
                ExceptionMessageInfoDto emiDto = new ExceptionMessageInfoDto();
                encapsulateExceptionMessageInfo(messageName, exceptionJmsMessageId, producerClassName, jmsMessageModel,
                        parameterClassName, maxRetryThreshold, emiDto);
                exceptionMessageOperationService.saveExceptionMessageInfo(emiDto);
                final ScheduledThreadPoolExecutor scheduledThreadPoolExecutor = new ScheduledThreadPoolExecutor(Runtime
                        .getRuntime().availableProcessors() + 1);
                for (int i = 1; i <= maxRetryThreshold; i++) {
                    scheduledThreadPoolExecutor.schedule(new Runnable() {
                        public void run() {
                            try {
                                WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                                IBaseSender bs = (IBaseSender) wac.getBean(Class.forName(producerClassName));
                                bs.sendMessage(jmsMessageModel);
                            } catch (Exception e) {
                                logger.error(
                                        "重发消息出现系统异常！Message : " + JsonUtils.toJsonStringWithDateFormat(jmsMessageModel), e);
                                // 立即停止所有的重发线程
                                scheduledThreadPoolExecutor.shutdownNow();
                            }
                        };
                    }, i * intervalTime, TimeUnit.SECONDS);
                }
                // 将正在执行的重发线程全部执行完毕后再关闭scheduledThreadPoolExecutor定时任务
                scheduledThreadPoolExecutor.shutdown();
            } else {
                exceptionMessageInfoDto = exceptionMessageOperationService.loadExceptionMessageInfo(exceptionJmsMessageId);
                if (null != exceptionMessageInfoDto) {
                    Integer retryCount = exceptionMessageInfoDto.getRetryCount();
                    if (retryCount < maxRetryThreshold) {
                        if (retryCount.intValue() + 1 == maxRetryThreshold.intValue()) {
                            exceptionMessageOperationService
                                    .saveExceptionMessageManualHandlingFromExceptionMessageInfo(exceptionJmsMessageId);
                        } else {
                            exceptionMessageOperationService.updateRetryCountByExceptionJmsMessageId(exceptionJmsMessageId);
                        }
                    }
                }
            }
        } catch (Exception e) {
            try {
                if (null == exceptionMessageInfoDto) {
                    ExceptionMessageManualHandlingDto emmhDto = new ExceptionMessageManualHandlingDto();
                    encapsulateExceptionMessageManualHandling(messageName, producerClassName, jmsMessageModel,
                            parameterClassName, emmhDto);
                    exceptionMessageOperationService.saveExceptionMessageManualHandling(emmhDto);
                } else {
                    exceptionMessageOperationService
                            .saveExceptionMessageManualHandlingFromExceptionMessageInfo(exceptionJmsMessageId);
                }
            } catch (SystemServiceException e1) {
                logger.error("发送消息出现系统异常！", e1);
                throw new MessageException("发送消息出现系统异常 : " + e1.getMessage(), e1);
            }
            logger.error("发送消息出现系统异常！", e);
            throw new MessageException("发送消息出现系统异常 : " + e.getMessage(), e);
        }
    }

    private void encapsulateExceptionMessageManualHandling(String messageName, String producerClassName,
            JmsMessageModel jmsMessageModel, String parameterClassName, ExceptionMessageManualHandlingDto emmhDto) {
        emmhDto.setMessageName(messageName);
        emmhDto.setProducerClassName(producerClassName);
        emmhDto.setParameterClassName(parameterClassName);
        emmhDto.setParameterJsonString(JsonUtils.toJsonStringWithDateFormat(jmsMessageModel));
        emmhDto.setCrossDomainTransactionName(jmsMessageModel.getCrossDomainTransactionName());
        emmhDto.setCrossDomainTransactionId(jmsMessageModel.getCrossDomainTransactionId());
    }

    private void encapsulateExceptionMessageInfo(String messageName, String exceptionJmsMessageId, String producerClassName,
            JmsMessageModel jmsMessageModel, String parameterClassName, Integer maxRetryThreshold,
            ExceptionMessageInfoDto emiDto) {
        emiDto.setMessageName(messageName);
        emiDto.setExceptionJmsMessageId(exceptionJmsMessageId);
        emiDto.setProducerClassName(producerClassName);
        emiDto.setParameterJsonString(JsonUtils.toJsonStringWithDateFormat(jmsMessageModel));
        emiDto.setParameterClassName(parameterClassName);
        emiDto.setRetryCount(0);
        emiDto.setMaxRetryThreshold(maxRetryThreshold);
        emiDto.setCrossDomainTransactionName(jmsMessageModel.getCrossDomainTransactionName());
        emiDto.setCrossDomainTransactionId(jmsMessageModel.getCrossDomainTransactionId());
    }

    /**
     * 消费消息成功时的处理
     * 
     * @param jmsMessageModel
     *            消息的具体实体实例
     */
    public void handleSuccess(JmsMessageModel jmsMessageModel) throws MessageException {
        try {
            Integer exceptionMessageManualHandlingId = jmsMessageModel.getExceptionMessageManualHandlingId();
            // 如果为“人工触发 ”，消费消息成功时，删除人工处理表里的该条记录信息
            if (null != exceptionMessageManualHandlingId) {
                exceptionMessageOperationService.deleteExceptionMessageManualHandling(exceptionMessageManualHandlingId);
            }
            String exceptionJmsMessageId = jmsMessageModel.getExceptionJmsMessageId();
            // 如果为异常重发的消息，消费消息成功时，删除异常消息信息表里的该条记录信息（注：exceptionJmsMessageId不为空也可能是人工触发的消息，但在上一步已经处理过这种情况了，这里就不用再次删掉人工处理表里的该条记录信息）
            if (!StringUtils.isEmpty(exceptionJmsMessageId)) {
                exceptionMessageOperationService.deleteExceptionMessageInfo(exceptionJmsMessageId);
            }
        } catch (Exception e) {
            logger.error(e);
            throw new MessageException(e.getMessage(), e);
        }
    }

    public void handleSenderException(String messageName, String producerClassName, String parameterClassName,
            JmsMessageModel jmsMessageModel) {
        String str = null;
        try {
            if (StringUtils.isEmpty(messageName)) {
                str = "参数messageName不能为空";
                throw new MessageException(str);
            }
            if (StringUtils.isEmpty(producerClassName)) {
                str = "参数producerClassName不能为空";
                throw new MessageException(str);
            }
            if (StringUtils.isEmpty(parameterClassName)) {
                str = "参数parameterClassName不能为空";
                throw new MessageException(str);
            }
            if (null == jmsMessageModel) {
                str = "参数jmsMessageModel不能为空";
                throw new MessageException(str);
            }
            Integer exceptionMessageManualHandlingId = jmsMessageModel.getExceptionMessageManualHandlingId();
            if (null == exceptionMessageManualHandlingId) {
                if (StringUtils.isEmpty(jmsMessageModel.getExceptionJmsMessageId())) {
                    ExceptionMessageManualHandlingDto emmhDto = new ExceptionMessageManualHandlingDto();
                    encapsulateExceptionMessageManualHandling(messageName, producerClassName, jmsMessageModel,
                            parameterClassName, emmhDto);
                    exceptionMessageOperationService.saveExceptionMessageManualHandling(emmhDto);
                } else {
                    ExceptionMessageInfoDto exceptionMessageInfoDto = exceptionMessageOperationService
                            .loadExceptionMessageInfo(jmsMessageModel.getExceptionJmsMessageId());
                    if (null != exceptionMessageInfoDto) {
                        exceptionMessageOperationService
                                .saveExceptionMessageManualHandlingFromExceptionMessageInfo(jmsMessageModel
                                        .getExceptionJmsMessageId());
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e);
            if (!StringUtils.isEmpty(str)) {
                throw new IllegalArgumentException(str);
            } else {
                throw new IllegalStateException(e.getMessage(), e);
            }
        }
    }

    public IExceptionMessageOperationService getExceptionMessageOperationService() {
        return exceptionMessageOperationService;
    }

    public void setExceptionMessageOperationService(IExceptionMessageOperationService exceptionMessageOperationService) {
        this.exceptionMessageOperationService = exceptionMessageOperationService;
    }

}
