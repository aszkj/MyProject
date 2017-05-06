package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：异常消息信息实体类，映射表 YiLiDiSystemCenter.S_EXCEPTION_MESSAGE_INFO <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ExceptionMessageInfo extends BaseModel {
	private static final long serialVersionUID = -6090609328665432013L;

	/**
	 * ID 自增主键
	 */
	private Integer id;

	/**
	 * 消息名称
	 */
	private String messageName;

	/**
	 * 异常JMS消息ID
	 */
	private String exceptionJmsMessageId;

	/**
	 * 消息生产者所属的实体模型类的全名
	 */
	private String producerClassName;

	/**
	 * 发送的消息参数JSON字符串
	 */
	private String parameterJsonString;

	/**
	 * 发送的消息参数所属的实体模型类的全名
	 */
	private String parameterClassName;

	/**
	 * 重试的次数（初始为0，以后每重试一次该值加1）
	 */
	private Integer retryCount;

	/**
	 * 最大的重试阈值
	 */
	private Integer maxRetryThreshold;

	/**
	 * 跨域事务名称（用户跟踪异常的跨域事务）
	 */
	private String crossDomainTransactionName;

	/**
	 * 跨域事务ID（用户跟踪异常的跨域事务）
	 */
	private String crossDomainTransactionId;

	/**
	 * 创建时间
	 */
	private Date createTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getMessageName() {
		return messageName;
	}

	public void setMessageName(String messageName) {
		this.messageName = messageName;
	}

	public String getExceptionJmsMessageId() {
		return exceptionJmsMessageId;
	}

	public void setExceptionJmsMessageId(String exceptionJmsMessageId) {
		this.exceptionJmsMessageId = exceptionJmsMessageId;
	}

	public String getProducerClassName() {
		return producerClassName;
	}

	public void setProducerClassName(String producerClassName) {
		this.producerClassName = producerClassName;
	}

	public String getParameterJsonString() {
		return parameterJsonString;
	}

	public void setParameterJsonString(String parameterJsonString) {
		this.parameterJsonString = parameterJsonString;
	}

	public String getParameterClassName() {
		return parameterClassName;
	}

	public void setParameterClassName(String parameterClassName) {
		this.parameterClassName = parameterClassName;
	}

	public Integer getRetryCount() {
		return retryCount;
	}

	public void setRetryCount(Integer retryCount) {
		this.retryCount = retryCount;
	}

	public Integer getMaxRetryThreshold() {
		return maxRetryThreshold;
	}

	public void setMaxRetryThreshold(Integer maxRetryThreshold) {
		this.maxRetryThreshold = maxRetryThreshold;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

}