/**
 * 文件名称：EmailMessageSender.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.jms.sender;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 功能描述：邮件消息发送者 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class EmailMessageSender extends AbstractSender {

	@Autowired
	private JmsTemplate emailTopicSendJmsTemplate;

	@Override
	public void doSend(JmsMessageModel jmsMessageModel) {
		emailTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
	}

}
