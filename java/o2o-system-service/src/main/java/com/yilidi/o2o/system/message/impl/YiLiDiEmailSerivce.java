package com.yilidi.o2o.system.message.impl;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.yilidi.o2o.common.InitConfig;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.exception.ServiceLevelException;
import com.yilidi.o2o.core.model.EmailMessageModel;
import com.yilidi.o2o.system.message.IEmailSerivce;
import com.yilidi.o2o.system.model.SmsNotifyMessage;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 
 * @Description:TODO(邮件服务实现类)
 * @author: chenlian
 * @date: 2015年10月30日 下午8:39:43
 * 
 */
public class YiLiDiEmailSerivce implements IEmailSerivce {

	private Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 邮件内容模版中定义的变量（用户名），为了同一处理，约定：所有Email内容模版中“用户名”变量均须为"userName"
	 */
	private static final String CONTENT_TEMPLATE_VARIABLE_USER_NAME = "userName";

	private JavaMailSender mailSender;

	private Template template;

	private Configuration freemarkerConfiguration;

	/**
	 * 发送邮件
	 * 
	 * @throws ServiceLevelException
	 */
	@Override
	public void sendEmail(EmailMessageModel email) throws MessageException {
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(msg, true, CommonConstants.UTF_8);
			this.template = freemarkerConfiguration.getTemplate(
					InitConfig.emailMessageConfigParams.get(email.getContentTemplateNamePropertiesKey()),
					CommonConstants.UTF_8);
			helper.setSubject(InitConfig.emailMessageConfigParams.get(email.getTitlePropertiesKey()));
			KeyValuePair<String, String> fromUserNameAndEmailInfo = email.getFromUserNameAndEmailInfo();
			List<KeyValuePair<String, String>> toUserNameAndEmailInfoList = email.getToUserNameAndEmailInfoList();
			helper.setFrom(fromUserNameAndEmailInfo.getValue());
			for (KeyValuePair<String, String> kv : toUserNameAndEmailInfoList) {
				helper.setTo(kv.getValue());
				Map<String, String> contentVariablesMap = email.getContentVariablesMap();
				contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_USER_NAME, kv.getKey());
				String content = FreeMarkerTemplateUtils.processTemplateIntoString(template, contentVariablesMap);
				helper.setText(content, true);
				mailSender.send(msg);
				logger.info("发送邮件到[" + kv.getKey() + "]成功, 邮件地址：[" + kv.getValue() + "]");
				// 记录日志到数据库
				SmsNotifyMessage smsNotifyMessage = new SmsNotifyMessage();

			}
		} catch (Exception e) {
			logger.error("发送邮件异常：" + e.getMessage());
			throw new MessageException(e);
		}
	}

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	/**
	 * 注入Freemarker引擎配置,构造Freemarker 邮件内容模板.
	 * 
	 * @param freemarkerConfiguration
	 *            freeMarker配置
	 * @throws IOException
	 *             IO异常
	 */
	public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) throws IOException {
		this.freemarkerConfiguration = freemarkerConfiguration;
	}

}
