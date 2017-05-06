package com.yilidi.o2o.system.message.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.yilidi.o2o.common.InitConfig;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.system.message.ISmsService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.sms.huaxin.SmsHuaxinUtils;
import com.yilidi.o2o.system.sms.huaxin.model.send.SendReturnInfo;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 
 * @Description:TODO(发送短信Service服务类)
 * @author: chenlian
 * @date: 2015年10月28日 下午9:43:05
 * 
 */
public class YiLiDiSmsService implements ISmsService {

    private Logger logger = Logger.getLogger(this.getClass());

    private SmsHuaxinUtils smsHuaxinUtils;

    private ISmsNotifyMessageService smsNotifyMessageService;

    private Configuration freemarkerConfiguration;

    private static final String SEND_SMS_SUCCESS = "Success";

    private static final String SEND_SMS_FAILD = "Faild";

    @Override
    public void sendSms(SmsMessageModel sms) {
        try {
            Template template = freemarkerConfiguration.getTemplate(
                    InitConfig.smsMessageConfigParams.get(sms.getContentTemplateNamePropertiesKey()), CommonConstants.UTF_8);
            List<String> toUserMobileList = sms.getToUserMobileList();
            String phones = "";
            for (int i = 0; i < toUserMobileList.size(); i++) {
                if (i == toUserMobileList.size() - 1) {
                    phones += toUserMobileList.get(i);
                } else {
                    phones += toUserMobileList.get(i) + ",";
                }
            }
            Map<String, String> contentVariablesMap = sms.getContentVariablesMap();
            String content = FreeMarkerTemplateUtils.processTemplateIntoString(template, contentVariablesMap);
            SendReturnInfo sendReturnInfo = smsHuaxinUtils.send(phones, content);
            updateSendStatus(sms, sendReturnInfo);
            logger.info("调用发送短信接口成功, 短信接受人手机号：" + phones);
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "发送短信异常" : e.getMessage();
            logger.error(msg, e);
            throw new MessageException(msg);
        }
    }

    private void updateSendStatus(SmsMessageModel sms, SendReturnInfo sendReturnInfo) {
        List<Integer> smsNotifyMessageIdList = sms.getSmsNotifyMessageIdList();
        List<SmsNotifyMessageDto> smsNotifyMessageDtoList = new ArrayList<SmsNotifyMessageDto>(smsNotifyMessageIdList.size());
        for (Integer smsNotifyMessageId : smsNotifyMessageIdList) {
            SmsNotifyMessageDto smsNotifyMessageDto = new SmsNotifyMessageDto();
            smsNotifyMessageDto.setId(smsNotifyMessageId);
            smsNotifyMessageDto.setSmsJobId(sendReturnInfo.getTaskID());
            if (SEND_SMS_SUCCESS.equals(sendReturnInfo.getReturnstatus())) {
                smsNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_SUCCEED);
            }
            if (SEND_SMS_FAILD.equals(sendReturnInfo.getReturnstatus())) {
                smsNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_FAILED);
            }
            smsNotifyMessageDtoList.add(smsNotifyMessageDto);
        }
        smsNotifyMessageService.updateSendStatus(smsNotifyMessageDtoList);
    }

    public SmsHuaxinUtils getSmsHuaxinUtils() {
        return smsHuaxinUtils;
    }

    public void setSmsHuaxinUtils(SmsHuaxinUtils smsHuaxinUtils) {
        this.smsHuaxinUtils = smsHuaxinUtils;
    }

    public ISmsNotifyMessageService getSmsNotifyMessageService() {
        return smsNotifyMessageService;
    }

    public void setSmsNotifyMessageService(ISmsNotifyMessageService smsNotifyMessageService) {
        this.smsNotifyMessageService = smsNotifyMessageService;
    }

    public Configuration getFreemarkerConfiguration() {
        return freemarkerConfiguration;
    }

    public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) {
        this.freemarkerConfiguration = freemarkerConfiguration;
    }

}
