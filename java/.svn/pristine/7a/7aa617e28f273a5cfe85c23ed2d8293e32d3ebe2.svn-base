/**
 * 文件名称：JmsMessageModel.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.model;

import java.io.Serializable;

/**
 * 功能描述：发送消息实体模型基类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class JmsMessageModel implements Serializable {

	private static final long serialVersionUID = 4857177956875316833L;

	/**
	 * 消息名称（自定义该消息的名称，可在异常消息人工处理列表中显示出来，便于知晓处理的是什么消息。默认："MyMessage:" + System.currentTimeMillis()）
	 */
	private String messageName;

	/**
	 * 消息生产者所属的实体模型类的全名
	 */
	private String producerClassName;

	/**
	 * 最大的重试阈值（自定义该消息的最大重试阈值，默认：SystemContext.SystemParams.MESSAGE_MAX_RETRY_THRESHOLD_DEFAULT）
	 */
	private Integer maxRetryThreshold;

	/**
	 * 重发时间间隔（自定义该消息的重发时间间隔，单位：秒，默认：SystemContext.SystemParams.MESSAGE_INTERVAL_TIME_DEFAULT）
	 */
	private Integer intervalTime;

	/**
	 * 异常JMS消息ID
	 */
	public String exceptionJmsMessageId;

	/**
	 * 异常消息人工处理
	 */
	public Integer exceptionMessageManualHandlingId;

	/**
	 * 跨域事务名称（用户跟踪异常的跨域事务）
	 */
	private String crossDomainTransactionName;

	/**
	 * 跨域事务ID（用户跟踪异常的跨域事务）
	 */
	private String crossDomainTransactionId;

	public String getMessageName() {
		return messageName;
	}

	public void setMessageName(String messageName) {
		this.messageName = messageName;
	}

	public String getProducerClassName() {
		return producerClassName;
	}

	public void setProducerClassName(String producerClassName) {
		this.producerClassName = producerClassName;
	}

	public Integer getMaxRetryThreshold() {
		return maxRetryThreshold;
	}

	public void setMaxRetryThreshold(Integer maxRetryThreshold) {
		this.maxRetryThreshold = maxRetryThreshold;
	}

	public Integer getIntervalTime() {
		return intervalTime;
	}

	public void setIntervalTime(Integer intervalTime) {
		this.intervalTime = intervalTime;
	}

	public String getExceptionJmsMessageId() {
		return exceptionJmsMessageId;
	}

	public void setExceptionJmsMessageId(String exceptionJmsMessageId) {
		this.exceptionJmsMessageId = exceptionJmsMessageId;
	}

	public Integer getExceptionMessageManualHandlingId() {
		return exceptionMessageManualHandlingId;
	}

	public void setExceptionMessageManualHandlingId(Integer exceptionMessageManualHandlingId) {
		this.exceptionMessageManualHandlingId = exceptionMessageManualHandlingId;
	}

	public String getCrossDomainTransactionName() {
		return crossDomainTransactionName;
	}

	public void setCrossDomainTransactionName(String crossDomainTransactionName) {
		this.crossDomainTransactionName = crossDomainTransactionName;
	}

	public String getCrossDomainTransactionId() {
		return crossDomainTransactionId;
	}

	public void setCrossDomainTransactionId(String crossDomainTransactionId) {
		this.crossDomainTransactionId = crossDomainTransactionId;
	}

}
