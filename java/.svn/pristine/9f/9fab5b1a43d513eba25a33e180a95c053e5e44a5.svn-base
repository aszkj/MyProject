package com.yilidi.o2o.system.jms.receiver;

import javax.jms.Message;
import javax.jms.ObjectMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.system.jms.converter.O2oMessageConverter;
import com.yilidi.o2o.system.jms.handler.YiLiDiMessageHandler;
import com.yilidi.o2o.system.service.IMessageBusinessHandleAdapterService;

/**
 * 抽象消息接收者，利用模板方法来统一处理消息的接收，具体的接收业务逻辑由其子类实现。
 * 
 * @author chenl
 * 
 */
public abstract class AbstractReceiver implements IBaseReceiver {

	private Logger logger = Logger.getLogger(this.getClass());

	private O2oMessageConverter o2oMessageConverter;

	private YiLiDiMessageHandler yilidiMessageHandler;

	public IMessageBusinessHandleAdapterService messageBusinessHandleAdapterService;

	@Override
	public void onMessage(Message message) {
		logger.info("-------------------------- Recieve Message --------------------------");
		if (message instanceof ObjectMessage) {
			JmsMessageModel jmsMessageModel = null;
			String JMSMessageID = null;
			String messageName = null;
			String producerClassName = null;
			String parameterClassName = null;
			Integer maxRetryThreshold = null;
			Integer intervalTime = null;
			try {
				jmsMessageModel = (JmsMessageModel) o2oMessageConverter.fromMessage(message);
				messageName = jmsMessageModel.getMessageName();
				producerClassName = jmsMessageModel.getProducerClassName();
				parameterClassName = jmsMessageModel.getClass().getName();
				maxRetryThreshold = jmsMessageModel.getMaxRetryThreshold();
				intervalTime = jmsMessageModel.getIntervalTime();
				logger.info("messageName : " + messageName);
				logger.info("producerClassName : " + producerClassName);
				logger.info("parameterClassName : " + parameterClassName);
				logger.info("maxRetryThreshold : " + maxRetryThreshold);
				logger.info("intervalTime : " + intervalTime);
				logger.info("receiveMessage============>" + JsonUtils.toJsonStringWithDateFormat(jmsMessageModel));
				JMSMessageID = message.getJMSMessageID();
				if (!StringUtils.isEmpty(jmsMessageModel.getExceptionJmsMessageId())) {
					JMSMessageID = jmsMessageModel.getExceptionJmsMessageId();
				}
				if (yilidiMessageHandler.validateWhetherOrNotShouldHandleMessage(JMSMessageID, jmsMessageModel)) {
					doReceive(jmsMessageModel);
				}
			} catch (Exception e) {
				String msg = "系统出现异常";
				logger.error(msg, e);
				try {
					// 自定义消息消费异常处理，此处要catch住异常，不能再往外抛RuntimeException异常，否则，MQ会自动重发，与自定义重发产生冲突。
					yilidiMessageHandler.handleReceiverException(messageName, JMSMessageID, producerClassName,
							parameterClassName, jmsMessageModel, maxRetryThreshold, intervalTime);
				} catch (MessageException e1) {
					logger.error(e1.getMessage(), e1);
				}
			}
		} else {
			logger.error("消息转换异常，消息参数:[" + message + "]不是ObjectMessage类型");
		}
	}

	public abstract void doReceive(JmsMessageModel jmsMessageModel) throws MessageException;

	public O2oMessageConverter getO2oMessageConverter() {
		return o2oMessageConverter;
	}

	public void setO2oMessageConverter(O2oMessageConverter o2oMessageConverter) {
		this.o2oMessageConverter = o2oMessageConverter;
	}

	public YiLiDiMessageHandler getYilidiMessageHandler() {
		return yilidiMessageHandler;
	}

	public void setYilidiMessageHandler(YiLiDiMessageHandler yilidiMessageHandler) {
		this.yilidiMessageHandler = yilidiMessageHandler;
	}

	public IMessageBusinessHandleAdapterService getMessageBusinessHandleAdapterService() {
		return messageBusinessHandleAdapterService;
	}

	public void setMessageBusinessHandleAdapterService(
			IMessageBusinessHandleAdapterService messageBusinessHandleAdapterService) {
		this.messageBusinessHandleAdapterService = messageBusinessHandleAdapterService;
	}

}
