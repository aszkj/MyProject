package com.yilidi.o2o.system.service.impl;

import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.yilidi.o2o.common.InitConfig;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.EmailTypeModelClassMapping;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.EmailMessageModel;
import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.core.model.PushSystemMessageModel;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.jms.sender.IBaseSender;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.system.service.IPushNotifyMessageService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.PushNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

@Service("messageService")
public class MessageServiceImpl extends BasicDataService implements IMessageService {

    private static final String JMS_MODEL_PACKAGE_PREFIX = "com.yilidi.o2o.system.jms.model";

    private static final String SMS_PACKAGE = "sms";

    private static final String EMAIL_PACKAGE = "email";

    private static final String PUSH_PACKAGE = "push";
    
    /**
	 * 跳转类型对应的值
	 */
	public static final int SKIPTYPEONE = 1;
	public static final int SKIPTYPETWO = 2;
	public static final int SKIPTYPETHREE = 3;


    @Autowired
    private IBaseSender smsMessageSender;
    @Autowired
    private IBaseSender emailMessageSender;
    @Autowired
    private IBaseSender pushMessageSender;
    @Autowired
    private IBaseSender pushSellerSystemMessageSender;
    @Autowired
    private IBaseSender pushBuyerSystemMessageSender;
    @Autowired
    private Configuration smsFreemarkerConfiguration;
    @Autowired
    private Configuration pushFreemarkerConfiguration;
    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;
    @Autowired
    private IPushNotifyMessageService pushNotifyMessageService;
    @Autowired
    private ISystemMessageService systemMessageService;
    @Autowired
    private ISystemParamsService systemParamsService;

    private static final String SMS_SIGNATURE_PROPERTIES_KEY = "sms.huaxin.signature";

    @Override
    public void sendEmail(EmailTypeModelClassMapping mapping, KeyValuePair<String, String> fromUserNameAndEmailInfo,
            List<KeyValuePair<String, String>> toUserNameAndEmailInfoList, String... variables)
            throws SystemServiceException {
        try {
            EmailMessageModel emailMessageModel = getEmailMessageModel(mapping, fromUserNameAndEmailInfo,
                    toUserNameAndEmailInfoList, variables);
            emailMessageSender.sendMessage(emailMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送邮件消息异常", e);
        }
    }

    private EmailMessageModel getEmailMessageModel(EmailTypeModelClassMapping mapping,
            KeyValuePair<String, String> fromUserNameAndEmailInfo,
            List<KeyValuePair<String, String>> toUserNameAndEmailInfoList, String... variables)
            throws ClassNotFoundException, InstantiationException, IllegalAccessException, InvocationTargetException {
        Class<?> modelClass = null;
        modelClass = Class.forName(JMS_MODEL_PACKAGE_PREFIX + CommonConstants.DELIMITER_DOT + EMAIL_PACKAGE
                + CommonConstants.DELIMITER_DOT + mapping.getValue());
        Constructor<?> modelConstructors[] = modelClass.getDeclaredConstructors();
        Constructor<?> modelConstructor = modelConstructors[0];
        modelConstructor.setAccessible(true);
        EmailMessageModel emailMessageModel = (EmailMessageModel) modelConstructor.newInstance(fromUserNameAndEmailInfo,
                toUserNameAndEmailInfoList, variables);
        logger.info("==========> emailMessageModel : " + JsonUtils.toJsonStringWithDateFormat(emailMessageModel));
        return emailMessageModel;
    }

    @Override
    public void userSendSms(SmsTypeModelClassMapping mapping, String remoteIpAddr, List<String> toUserMobileList,
            String... variables) throws SystemServiceException {
        try {
            SmsMessageModel smsMessageModel = getSmsMessageModel(mapping, toUserMobileList, variables);
            List<Integer> smsNotifyMessageIdList = batchSaveSmsNotifyMessageInfos(remoteIpAddr, smsMessageModel);
            smsMessageModel.setSmsNotifyMessageIdList(smsNotifyMessageIdList);
            if (CommonConstants.S_CALL_SMS_INTERFACE_FLAG_YES
                    .equals(getSystemParamValue(SystemContext.SystemParams.S_CALL_SMS_INTERFACE_FLAG))) {
                smsMessageSender.sendMessage(smsMessageModel);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new SystemServiceException("发送短信消息异常", e);
        }
    }

    @Override
    public void systemSendSms(SmsTypeModelClassMapping mapping, List<String> toUserMobileList, String... variables)
            throws SystemServiceException {
        try {
            SmsMessageModel smsMessageModel = getSmsMessageModel(mapping, toUserMobileList, variables);
            List<Integer> smsNotifyMessageIdList = batchSaveSmsNotifyMessageInfos(null, smsMessageModel);
            smsMessageModel.setSmsNotifyMessageIdList(smsNotifyMessageIdList);
            if (CommonConstants.S_CALL_SMS_INTERFACE_FLAG_YES
                    .equals(getSystemParamValue(SystemContext.SystemParams.S_CALL_SMS_INTERFACE_FLAG))) {
                smsMessageSender.sendMessage(smsMessageModel);
            }
        } catch (Exception e) {
            throw new SystemServiceException("发送短信消息异常", e);
        }
    }

    private List<Integer> batchSaveSmsNotifyMessageInfos(String remoteIpAddr, SmsMessageModel smsMessageModel)
            throws IOException, TemplateException {
        Template template = smsFreemarkerConfiguration.getTemplate(
                InitConfig.smsMessageConfigParams.get(smsMessageModel.getContentTemplateNamePropertiesKey()),
                CommonConstants.UTF_8);
        List<String> toMobileList = smsMessageModel.getToUserMobileList();
        Map<String, String> contentVariablesMap = smsMessageModel.getContentVariablesMap();
        List<SmsNotifyMessageDto> smsNotifyMessageDtoList = new ArrayList<SmsNotifyMessageDto>();
        for (String toMobile : toMobileList) {
            SmsNotifyMessageDto smsNotifyMessageDto = new SmsNotifyMessageDto();
            smsNotifyMessageDto.setContent(InitConfig.smsMessageConfigParams.get(SMS_SIGNATURE_PROPERTIES_KEY)
                    + FreeMarkerTemplateUtils.processTemplateIntoString(template, contentVariablesMap));
            smsNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT);
            smsNotifyMessageDto.setRemoteIpAddr(remoteIpAddr);
            smsNotifyMessageDto.setReportStatus(SystemContext.SystemDomain.NOTIFYMSGREPORTSTATUS_NOTYET);
            smsNotifyMessageDto.setSendTime(new Date());
            smsNotifyMessageDto.setSmsMsgType(smsMessageModel.getSmsMsgType());
            smsNotifyMessageDto.setSmsProvideType(smsMessageModel.getSmsProvideType());
            smsNotifyMessageDto.setToUser(toMobile);
            smsNotifyMessageDtoList.add(smsNotifyMessageDto);
        }
        List<Integer> idList = smsNotifyMessageService.saveBatch(smsNotifyMessageDtoList);
        return idList;
    }

    private SmsMessageModel getSmsMessageModel(SmsTypeModelClassMapping mapping, List<String> toUserMobileList,
            String... variables)
            throws ClassNotFoundException, InstantiationException, IllegalAccessException, InvocationTargetException {
        Class<?> modelClass = null;
        modelClass = Class.forName(JMS_MODEL_PACKAGE_PREFIX + CommonConstants.DELIMITER_DOT + SMS_PACKAGE
                + CommonConstants.DELIMITER_DOT + mapping.getValue());
        Constructor<?> modelConstructors[] = modelClass.getDeclaredConstructors();
        Constructor<?> modelConstructor = modelConstructors[0];
        modelConstructor.setAccessible(true);
        SmsMessageModel smsMessageModel = null;
        if (variables.length == 0) {
            smsMessageModel = (SmsMessageModel) modelConstructor.newInstance(toUserMobileList);
        } else {
            smsMessageModel = (SmsMessageModel) modelConstructor.newInstance(toUserMobileList, variables);
        }
        logger.info("==========> smsMessageModel : " + JsonUtils.toJsonStringWithDateFormat(smsMessageModel));
        return smsMessageModel;
    }

    @Override
    public void sendPushOrderMessage(PushTypeModelClassMapping mapping, List<Integer> toUserIdList, String... variables)
            throws SystemServiceException {
        try {
            PushMessageModel pushMessageModel = getPushMessageModel(mapping, toUserIdList, variables);
            List<Integer> pushNotifyMessageIdList = batchSavePushNotifyMessageInfos(pushMessageModel);
            pushMessageModel.setPushNotifyMessageIdList(pushNotifyMessageIdList);
            pushMessageSender.sendMessage(pushMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送推送消息异常", e);
        }
    }

    private List<Integer> batchSavePushNotifyMessageInfos(PushMessageModel pushMessageModel)
            throws IOException, TemplateException {
        Template template = pushFreemarkerConfiguration.getTemplate(
                InitConfig.pushMessageConfigParams.get(pushMessageModel.getContentTemplateNamePropertiesKey()),
                CommonConstants.UTF_8);
        List<Integer> toIdList = pushMessageModel.getToUserIdList();
        Map<String, String> contentVariablesMap = pushMessageModel.getContentVariablesMap();
        List<PushNotifyMessageDto> pushNotifyMessageDtoList = new ArrayList<PushNotifyMessageDto>();
        for (Integer userId : toIdList) {
            PushNotifyMessageDto pushNotifyMessageDto = new PushNotifyMessageDto();
            pushNotifyMessageDto
                    .setContent(FreeMarkerTemplateUtils.processTemplateIntoString(template, contentVariablesMap));
            pushNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT);
            pushNotifyMessageDto.setSendTime(new Date());
            pushNotifyMessageDto.setPushMsgType(pushMessageModel.getPushMsgType());
            pushNotifyMessageDto.setPushProvideType(pushMessageModel.getPushProvideType());
            pushNotifyMessageDto.setToUser(userId);
            pushNotifyMessageDtoList.add(pushNotifyMessageDto);
        }
        List<Integer> idList = pushNotifyMessageService.saveBatch(pushNotifyMessageDtoList);
        return idList;
    }

    private PushMessageModel getPushMessageModel(PushTypeModelClassMapping mapping, List<Integer> toUserIdList,
            String... variables)
            throws ClassNotFoundException, InstantiationException, IllegalAccessException, InvocationTargetException {
        Class<?> modelClass = null;
        modelClass = Class.forName(JMS_MODEL_PACKAGE_PREFIX + CommonConstants.DELIMITER_DOT + PUSH_PACKAGE
                + CommonConstants.DELIMITER_DOT + mapping.getValue());
        Constructor<?> modelConstructors[] = modelClass.getDeclaredConstructors();
        Constructor<?> modelConstructor = modelConstructors[0];
        modelConstructor.setAccessible(true);
        PushMessageModel pushMessageModel = null;
        if (variables.length == 0) {
            pushMessageModel = (PushMessageModel) modelConstructor.newInstance(toUserIdList);
        } else {
            pushMessageModel = (PushMessageModel) modelConstructor.newInstance(toUserIdList, variables);
        }
        logger.info("==========> pushMessageModel : " + JsonUtils.toJsonStringWithDateFormat(pushMessageModel));
        return pushMessageModel;
    }

    //发送卖家系统消息
	@Override
	public void sendSellerPushMystemMessage(int pushWay, List<Integer> toUserIdList, SystemMessageDto systemMessageDto) {
		//组装model
		PushSystemMessageModel pushSystemMessageModel = getPushSystemMessageModel(pushWay,toUserIdList,systemMessageDto);
		pushSellerSystemMessageSender.sendMessage(pushSystemMessageModel);
	}
	
	//发送买家系统消息
	@Override
	public void sendBuyerPushMystemMessage(int pushWay, List<Integer> toUserIdList, SystemMessageDto systemMessageDto) {
		//组装model
		PushSystemMessageModel pushSystemMessageModel = getPushSystemMessageModel(pushWay,toUserIdList,systemMessageDto);
		pushBuyerSystemMessageSender.sendMessage(pushSystemMessageModel);
	}

	//处理model组装数据
	private PushSystemMessageModel getPushSystemMessageModel(int pushWay, List<Integer> toUserIdList,
			SystemMessageDto systemMessageDto) {
		if (ObjectUtils.isNullOrEmpty(toUserIdList)) {
            throw new IllegalArgumentException("参数：toUserIdList 不能为空！");
        }
		if(ObjectUtils.isNullOrEmpty(systemMessageDto)){
			throw new IllegalArgumentException("参数：systemMessageDto 不能为空！");
		}
		PushSystemMessageModel PushSystemMessageModel = new PushSystemMessageModel();
		PushSystemMessageModel.setToUserIdList(toUserIdList);
		PushSystemMessageModel.setPushWay(pushWay);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("msgId", systemMessageDto.getId());
		resultMap.put("msgTitle", systemMessageDto.getMessageTitle());
		resultMap.put("msgImage", systemMessageDto.getMessageImage());
		resultMap.put("msgTime", systemMessageDto.getAddTime());
		resultMap.put("msgAbstract", systemMessageDto.getMessageIntro());
		resultMap.put("directType", getSkipTypeValue(systemMessageDto.getSkipType()));
		resultMap.put("directCode", systemMessageDto.getSkipObject());
		PushSystemMessageModel.setContent(JsonUtils.toJsonStringWithDateFormat(resultMap));
//		PushSystemMessageModel.setPushMsgType(SystemContext.SystemDomain.PUSHNOTIFYMSGTYPE_SYSTEMMESSAGE);//预留字段
		PushSystemMessageModel.setPushProvideType(SystemContext.SystemDomain.PUSHNOTIFYPROVIDETYPE_GETUI);
		PushSystemMessageModel.setPushNotifyMessageIdList(batchSavePushNotifyMessageInfos(PushSystemMessageModel));
		return PushSystemMessageModel;
	}
	
	private int getSkipTypeValue(String skipType) {
		int num = 0;
		if(StringUtils.isEmpty(skipType)){
			return num;
		}
		switch (skipType) {
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_COUPON:
			num = SKIPTYPEONE;
			break;
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_REFUND:
			num = SKIPTYPETWO;
			break;
		case SystemContext.SystemDomain.MESSAGESKIPTYPE_THEME:
			num = SKIPTYPETHREE;
			break;
		}
		return num;
	}

	private List<Integer> batchSavePushNotifyMessageInfos(PushSystemMessageModel pushSystemMessageModel) {
        List<Integer> toIdList = pushSystemMessageModel.getToUserIdList();
        List<PushNotifyMessageDto> pushNotifyMessageDtoList = new ArrayList<PushNotifyMessageDto>();
        for (Integer userId : toIdList) {
            PushNotifyMessageDto pushNotifyMessageDto = new PushNotifyMessageDto();
            pushNotifyMessageDto.setContent(pushSystemMessageModel.getContent());
            pushNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_INIT);
            pushNotifyMessageDto.setSendTime(new Date());
            pushNotifyMessageDto.setPushMsgType(pushSystemMessageModel.getPushMsgType());
            pushNotifyMessageDto.setPushProvideType(pushSystemMessageModel.getPushProvideType());
            pushNotifyMessageDto.setToUser(userId);
            pushNotifyMessageDtoList.add(pushNotifyMessageDto);
        }
        List<Integer> idList = pushNotifyMessageService.saveBatch(pushNotifyMessageDtoList);
        return idList;
	}

	@Override
	public void sendRefundMessage(Integer userId, String saleOrderNo, long refundAmount) {
		SystemParamsDto param = systemParamsService.loadByParamsCode(SystemContext.SystemParams.USER_REFUND_MESSAGE_SET);
		int pushWay = 0;
		if(!ObjectUtils.isNullOrEmpty(param)){
			if(param.getParamValue().equals("USER_REFUND_MESSAGE_SET_ON")){
				SystemMessageDto systemMessageDto = new SystemMessageDto();
				systemMessageDto.setMessageTypeGroup(SystemContext.SystemDomain.MESSAGETYPEGROUP_USERGROUP);
				systemMessageDto.setMessageType(SystemContext.SystemDomain.USERMESSAGETYPE_REFUND_MESSAGE);
				systemMessageDto.setMessageTitle("退款申请已受理");
				systemMessageDto.setMessageIntro("亲爱的用户,您发起一笔 "+refundAmount/1000+" 元的退款已申请成功。");
				systemMessageDto.setSkipType(SystemContext.SystemDomain.MESSAGESKIPTYPE_REFUND);
				systemMessageDto.setSkipObject(saleOrderNo);
				systemMessageDto.setPublishObject(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL);
				systemMessageDto.setPublishObjectValue(userId.toString());
				systemMessageDto.setAddUser(CommonConstants.SYSTEM_USER_ID);
				systemMessageDto.setAddTime(new Date());
				systemMessageDto.setCheckStatus(SystemContext.SystemDomain.MESSAGECHECKSTATUS_OK);
				systemMessageDto.setCheckUser(CommonConstants.SYSTEM_USER_ID);
				systemMessageDto.setCheckTime(new Date());
				int num = systemMessageService.addSystemMessage(systemMessageDto);
				if(num > 0){
					if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL) || systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_SPECIAL)){
						pushWay = 1;
					}else{
						pushWay = 2;
					}
					List<Integer> userIdList = new ArrayList<Integer>();
					userIdList.add(userId);
					//推送消息
					this.sendBuyerPushMystemMessage(pushWay,userIdList, systemMessageDto);
				}
			}
		}
	}

	@Override
	public void sendPreferenceMessage(Integer user, List<Integer> userIdList, String messageTitle, String messageIntro,String publishObject) {
		SystemParamsDto param = systemParamsService.loadByParamsCode(SystemContext.SystemParams.COUPON_GET_MESSAGE_SET);
		int pushWay = 0;
		if(!ObjectUtils.isNullOrEmpty(param)){
			if(param.getParamValue().equals("COUPON_GET_MESSAGE_SET_ON")){
				SystemMessageDto systemMessageDto = new SystemMessageDto();
				systemMessageDto.setMessageTypeGroup(SystemContext.SystemDomain.MESSAGETYPEGROUP_USERGROUP);
				systemMessageDto.setMessageType(SystemContext.SystemDomain.USERMESSAGETYPE_PREFERENCE_MESSAGE);
				systemMessageDto.setMessageTitle(messageTitle);
				systemMessageDto.setMessageIntro(messageIntro);
				systemMessageDto.setSkipType(SystemContext.SystemDomain.MESSAGESKIPTYPE_COUPON);
				systemMessageDto.setPublishObject(publishObject);
				if(publishObject.equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL)){
					if(!ObjectUtils.isNullOrEmpty(userIdList)){
						String publishObjectValue = "";
						for (Integer userId : userIdList) {
							publishObjectValue += userId + ",";
						}
						publishObjectValue = publishObjectValue.substring(0, publishObjectValue.length()-1);
						systemMessageDto.setPublishObjectValue(publishObjectValue);
					}
				}
				systemMessageDto.setAddUser(user);
				systemMessageDto.setAddTime(new Date());
				systemMessageDto.setCheckStatus(SystemContext.SystemDomain.MESSAGECHECKSTATUS_OK);
				systemMessageDto.setCheckUser(user);
				systemMessageDto.setCheckTime(new Date());
				int num = systemMessageService.addSystemMessage(systemMessageDto);
				if(num > 0){
					if(systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL) || systemMessageDto.getPublishObject().equals(SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_SELLER_SPECIAL)){
						pushWay = 1;
					}else{
						pushWay = 2;
					}
					//推送消息
					this.sendBuyerPushMystemMessage(pushWay, userIdList, systemMessageDto);
				}
			}
		}
	}

}
