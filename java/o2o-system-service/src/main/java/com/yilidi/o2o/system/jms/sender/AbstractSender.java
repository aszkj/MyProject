package com.yilidi.o2o.system.jms.sender;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.system.jms.handler.YiLiDiMessageHandler;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

/**
 * 抽象消息发送者，利用模板方法来统一处理消息的发送，具体的发送操作由其子类实现。
 * 
 * @author chenl
 * 
 */
public abstract class AbstractSender implements IBaseSender {

	private Logger logger = Logger.getLogger(this.getClass());

	private ISystemParamsService systemParamsService;

	private YiLiDiMessageHandler yilidiMessageHandler;

	public void sendMessage(JmsMessageModel jmsMessageModel) throws MessageException {
		logger.info("-------------------------- Send Message --------------------------");
		String messageName = null;
		String producerClassName = null;
		String parameterClassName = null;
		try {
			if (null == jmsMessageModel) {
				String msg = "发送消息的参数jmsMessageModel不能为空！";
				logger.error(msg);
				throw new MessageException(msg);
			}
			Integer maxRetryThreshold = jmsMessageModel.getMaxRetryThreshold();
			Integer intervalTime = jmsMessageModel.getIntervalTime();
			messageName = jmsMessageModel.getMessageName();
			parameterClassName = jmsMessageModel.getClass().getName();
			if (StringUtils.isEmpty(messageName)) {
				messageName = "MyMessage:" + System.currentTimeMillis();
				jmsMessageModel.setMessageName(messageName);
			}
			producerClassName = this.getClass().getName();
			jmsMessageModel.setProducerClassName(producerClassName);
			if (null == jmsMessageModel.getMaxRetryThreshold()) {
				String paramValue = SystemBasicDataUtils
						.getSystemParamValue(SystemContext.SystemParams.MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT);
				if (!StringUtils.isEmpty(paramValue)) {
					maxRetryThreshold = new Integer(paramValue);
				} else {
					SystemParamsDto systemParamsDto = systemParamsService
							.loadByParamsCode(SystemContext.SystemParams.MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT);
					maxRetryThreshold = null == systemParamsDto ? 5 : new Integer(systemParamsDto.getParamValue());
				}
				jmsMessageModel.setMaxRetryThreshold(maxRetryThreshold);
			}
			if (null == jmsMessageModel.getIntervalTime()) {
				String paramValue = SystemBasicDataUtils
						.getSystemParamValue(SystemContext.SystemParams.MESSAGE_INTERVAL_TIME_DEFAULT);
				if (!StringUtils.isEmpty(paramValue)) {
					intervalTime = new Integer(paramValue);
				} else {
					SystemParamsDto systemParamsDto = systemParamsService
							.loadByParamsCode(SystemContext.SystemParams.MESSAGE_INTERVAL_TIME_DEFAULT);
					intervalTime = null == systemParamsDto ? 20 : new Integer(systemParamsDto.getParamValue());
				}
				jmsMessageModel.setIntervalTime(intervalTime);
			}
			logger.info("messageName : " + messageName);
			logger.info("producerClassName : " + producerClassName);
			logger.info("parameterClassName : " + parameterClassName);
			logger.info("maxRetryThreshold : " + maxRetryThreshold);
			logger.info("intervalTime : " + intervalTime);
			logger.info("sendMessage============>" + JsonUtils.toJsonStringWithDateFormat(jmsMessageModel));
			doSend(jmsMessageModel);
		} catch (Exception e) {
			if (null != jmsMessageModel) {
				String msg = "系统出现异常";
				logger.error(msg, e);
				yilidiMessageHandler.handleSenderException(messageName, producerClassName, parameterClassName,
						jmsMessageModel);
			}
			throw new MessageException("系统出现异常：" + e.getMessage(), e);
		}
	}

	public abstract void doSend(JmsMessageModel jmsMessageModel);

	public ISystemParamsService getSystemParamsService() {
		return systemParamsService;
	}

	public void setSystemParamsService(ISystemParamsService systemParamsService) {
		this.systemParamsService = systemParamsService;
	}

	public YiLiDiMessageHandler getYilidiMessageHandler() {
		return yilidiMessageHandler;
	}

	public void setYilidiMessageHandler(YiLiDiMessageHandler yilidiMessageHandler) {
		this.yilidiMessageHandler = yilidiMessageHandler;
	}

}
