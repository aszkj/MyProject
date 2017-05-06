/**
 * 文件名称：SmsMessageSender.java
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
 * 功能描述：登录日志消息 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class LoginLogMessageSender extends AbstractSender {

    @Autowired
    private JmsTemplate loginLogTopicSendJmsTemplate;

    @Override
    public void doSend(JmsMessageModel jmsMessageModel) {
        loginLogTopicSendJmsTemplate.convertAndSend(jmsMessageModel);
    }

}
