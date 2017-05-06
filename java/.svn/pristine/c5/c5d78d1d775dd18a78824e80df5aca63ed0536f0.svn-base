package com.yilidi.o2o.core.transaction.model;

import com.yilidi.o2o.core.model.BaseModel;
import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 功能描述：回滚消息Model<br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class RollbackMessageModel extends BaseModel {
	private static final long serialVersionUID = -6090609328665432013L;

	/**
	 * Spring中配置的消息生产者BeanName
	 */
	private String producerBeanName;

	/**
	 * JMS Message实体模型
	 */
	private JmsMessageModel jmsMessageModel;

	public String getProducerBeanName() {
		return producerBeanName;
	}

	public void setProducerBeanName(String producerBeanName) {
		this.producerBeanName = producerBeanName;
	}

	public JmsMessageModel getJmsMessageModel() {
		return jmsMessageModel;
	}

	public void setJmsMessageModel(JmsMessageModel jmsMessageModel) {
		this.jmsMessageModel = jmsMessageModel;
	}

}