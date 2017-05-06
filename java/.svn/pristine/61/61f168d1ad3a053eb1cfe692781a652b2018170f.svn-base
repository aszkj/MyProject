/**
 * 文件名称：EmailMessageConverter.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.jms.converter;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.ObjectMessage;
import javax.jms.Session;

import org.apache.activemq.command.ActiveMQObjectMessage;
import org.springframework.jms.support.converter.MessageConversionException;
import org.springframework.jms.support.converter.MessageConverter;

/**
 * 功能描述：email 消息转换，发送消息时对象序列化，接受消息后反序列化 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class O2oMessageConverter implements MessageConverter {

	private static final String MSG = "msg";
	private static final String MSG_MAP = "msg_map";

	@Override
	public Object fromMessage(Message msg) throws JMSException, MessageConversionException {
		@SuppressWarnings("unchecked")
		HashMap<String, Object> map = (HashMap<String, Object>) ((ObjectMessage) msg).getObjectProperty(MSG_MAP);
		try {
			ByteArrayInputStream bis = new ByteArrayInputStream((byte[]) map.get(MSG));
			ObjectInputStream ois = new ObjectInputStream(bis);
			return ois.readObject();
		} catch (IOException e) {
			throw new MessageConversionException("FromMessage->消息转换IO异常,：" + e.getMessage(), e);
		} catch (ClassNotFoundException e) {
			throw new MessageConversionException("FromMessage->消息转换从流中读取对象异常：" + e.getMessage(), e);
		}
	}

	@Override
	public Message toMessage(Object obj, Session session) throws JMSException, MessageConversionException {
		ActiveMQObjectMessage objMsg = (ActiveMQObjectMessage) session.createObjectMessage();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			ObjectOutputStream oos = new ObjectOutputStream(bos);
			oos.writeObject(obj);
			bos.close();
			oos.close();
			map.put(MSG, bos.toByteArray());
			objMsg.setObjectProperty(MSG_MAP, map);
			return objMsg;
		} catch (Exception e) {
			throw new MessageConversionException("ToMessage->消息转换异常：" + e.getMessage(), e);
		}
	}
}
