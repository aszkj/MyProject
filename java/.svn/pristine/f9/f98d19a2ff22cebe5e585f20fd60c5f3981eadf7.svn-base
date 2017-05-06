/**
 * 文件名称：MessageProxyServiceImpl.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.proxy.impl;

import java.io.IOException;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.yilidi.o2o.common.InitConfig;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.EmailTypeModelClassMapping;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.PushTypeModelClassMapping;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.MessageException;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.EmailMessageModel;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.core.transaction.model.RollbackMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.jms.model.normal.BuyRewardActivityMessageModel;
import com.yilidi.o2o.system.jms.model.normal.LoginLogMessageModel;
import com.yilidi.o2o.system.jms.model.normal.SmallTableUserInfoMessageModel;
import com.yilidi.o2o.system.jms.model.normal.SynchroSaleProductRemainCountMessageModel;
import com.yilidi.o2o.system.jms.model.normal.SynchroShopCartListMessageModel;
import com.yilidi.o2o.system.jms.model.normal.UpdateUserAvatarMessageModel;
import com.yilidi.o2o.system.jms.model.normal.UserRegistAwardMessageModel;
import com.yilidi.o2o.system.jms.model.normal.UserShareAwardMessageModel;
import com.yilidi.o2o.system.jms.sender.IBaseSender;
import com.yilidi.o2o.system.jms.sender.SmsMessageSender;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemMessageProxyDto;
import com.yilidi.o2o.system.service.IMessageService;
import com.yilidi.o2o.system.service.IPushNotifyMessageService;
import com.yilidi.o2o.system.service.ISmsNotifyMessageService;
import com.yilidi.o2o.system.service.ISystemMessageService;
import com.yilidi.o2o.system.service.dto.PushNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.SmsNotifyMessageDto;
import com.yilidi.o2o.system.service.dto.SystemMessageDto;
import com.yilidi.o2o.user.proxy.dto.LoginLogProxyDto;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserShareAwardProxyDto;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 功能描述：消息代理服务实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("messageProxyService")
public class MessageProxyService extends BasicDataService implements IMessageProxyService {

    private static final String JMS_MODEL_PACKAGE_PREFIX = "com.yilidi.o2o.system.jms.model";

    private static final String SMS_PACKAGE = "sms";

    private static final String EMAIL_PACKAGE = "email";

    private static final String PUSH_PACKAGE = "push";

    @Autowired
    private IBaseSender emailMessageSender;
    @Autowired
    private SmsMessageSender smsMessageSender;
    @Autowired
    private IBaseSender pushMessageSender;
    @Autowired
    private Configuration smsFreemarkerConfiguration;
    @Autowired
    private Configuration pushFreemarkerConfiguration;
    @Autowired
    private ISmsNotifyMessageService smsNotifyMessageService;
    @Autowired
    private IPushNotifyMessageService pushNotifyMessageService;
    @Autowired
    private IBaseSender loginLogMessageSender;
    @Autowired
    private IBaseSender saveSmallTableUserInfoMessageSender;
    @Autowired
    private IBaseSender updateSmallTableUserInfoMessageSender;
    @Autowired
    private IBaseSender userShareAwardMessageSender;
    @Autowired
    private IBaseSender updateUserAvatarMessageSender;
    @Autowired
    private IBaseSender synchroShopCartMessageSender;
    @Autowired
    private IBaseSender synchroSaleProductRemainCountMessageSender;
    @Autowired
    private IBaseSender userRegistAwardMessageSender;
    @Autowired
    private IBaseSender buyRewardActivityMessageSender;
    @Autowired
    private IMessageService messageService;
    @Autowired
    private ISystemMessageService systemMessageService;

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
    public void sendPush(PushTypeModelClassMapping mapping, List<Integer> toUserIdList, String... variables)
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

    @Override
    public void sendRollbackTransactionMessage(Map<String, List<RollbackMessageModel>> rollbackMessageModelListMap)
            throws SystemServiceException {
        if (!ObjectUtils.isNullOrEmpty(rollbackMessageModelListMap)) {
            for (Map.Entry<String, List<RollbackMessageModel>> entry : rollbackMessageModelListMap.entrySet()) {
                List<RollbackMessageModel> rollbackMessageModelList = entry.getValue();
                if (!ObjectUtils.isNullOrEmpty(rollbackMessageModelList)) {
                    for (RollbackMessageModel rollbackMessageModel : rollbackMessageModelList) {
                        logger.info("rollbackMessageModel====================================> : "
                                + JsonUtils.toJsonStringWithDateFormat(rollbackMessageModel));
                        WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                        IBaseSender bs = (IBaseSender) wac.getBean(rollbackMessageModel.getProducerBeanName());
                        try {
                            JmsMessageModel jmsMessageModel = rollbackMessageModel.getJmsMessageModel();
                            bs.sendMessage(jmsMessageModel);
                        } catch (Exception e) {
                            logger.error(e);
                        }
                    }
                }
            }
        }
    }

    @Override
    public void sendLoginLogMessage(LoginLogProxyDto loginLogProxyDto) throws SystemServiceException {
        try {
            LoginLogMessageModel jmsMessageModel = new LoginLogMessageModel();
            ObjectUtils.copyProperties(loginLogProxyDto, jmsMessageModel);
            loginLogMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送登录日志消息异常", e);
        }
    }

    @Override
    public void sendSaveSynUserInfoMessage(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto)
            throws SystemServiceException {
        try {
            SmallTableUserInfoMessageModel jmsMessageModel = new SmallTableUserInfoMessageModel();
            ObjectUtils.copyProperties(smallTableUserInfoProxyDto, jmsMessageModel);
            saveSmallTableUserInfoMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送保存同步用户信息消息异常", e);
        }
    }

    @Override
    public void sendUpdateSynUserInfoMessage(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto)
            throws SystemServiceException {
        try {
            SmallTableUserInfoMessageModel jmsMessageModel = new SmallTableUserInfoMessageModel();
            ObjectUtils.copyProperties(smallTableUserInfoProxyDto, jmsMessageModel);
            updateSmallTableUserInfoMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送更新同步用户信息消息异常", e);
        }
    }

    @Override
    public void sendUserShareAwardMessage(UserShareAwardProxyDto userShareAwardProxyDto) throws SystemServiceException {
        try {
            UserShareAwardMessageModel jmsMessageModel = new UserShareAwardMessageModel();
            ObjectUtils.fastCopy(userShareAwardProxyDto, jmsMessageModel);
            userShareAwardMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送用户奖励消息异常", e);
        }
    }

    @Override
    public void sendUpdatUserAvatarMessage(Integer userId, String userAvatarUrl) throws SystemServiceException {
        try {
            UpdateUserAvatarMessageModel jmsMessageModel = new UpdateUserAvatarMessageModel();
            jmsMessageModel.setUserId(userId);
            jmsMessageModel.setUserAvatar(userAvatarUrl);
            updateUserAvatarMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送用户奖励消息异常", e);
        }
    }

    @Override
    public void sendAsycnShopCartMessage(Integer userId, List<ShopCartProxyDto> shopCartProxyDtoList)
            throws SystemServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(shopCartProxyDtoList)) {
                return;
            }
            SynchroShopCartListMessageModel jmsMessageModel = new SynchroShopCartListMessageModel();
            jmsMessageModel.setShopCartProxyDtoList(shopCartProxyDtoList);
            jmsMessageModel.setUserId(userId);
            synchroShopCartMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            throw new SystemServiceException("发送用户奖励消息异常", e);
        }
    }

    @Override
    public void sendSaleProductRemainChangeMessage(List<KeyValuePair<Integer, Integer>> saleProductIdAndRemainCountDeltaKeys,
            Integer userId) throws SystemServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleProductIdAndRemainCountDeltaKeys)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return;
            }
            SynchroSaleProductRemainCountMessageModel jmsMessageModel = new SynchroSaleProductRemainCountMessageModel();
            jmsMessageModel.setKeyValuePairs(saleProductIdAndRemainCountDeltaKeys);
            jmsMessageModel.setUserId(userId);
            synchroSaleProductRemainCountMessageSender.sendMessage(jmsMessageModel);
        } catch (Exception e) {
            logger.error(e, e);
            throw new SystemServiceException(e.getMessage());
        }

    }

    @Override
    public void sendUserRegistAwardMessage(Integer userId, Date nowTime) {
        try {
            UserRegistAwardMessageModel jmsMessageModel = new UserRegistAwardMessageModel();
            jmsMessageModel.setUserId(userId);
            jmsMessageModel.setNowTime(nowTime);
            userRegistAwardMessageSender.sendMessage(jmsMessageModel);
        } catch (MessageException e) {
            logger.error(e, e);
            throw new SystemServiceException(e.getMessage());
        }
    }

    @Override
    public void sendSellerPushMystemMessage(int pushWay, List<Integer> toUserIdList, SystemMessageProxyDto systemMessageProxyDto) {
        SystemMessageDto systemMessageDto = new SystemMessageDto();
        ObjectUtils.fastCopy(systemMessageProxyDto, systemMessageDto);
        messageService.sendSellerPushMystemMessage(pushWay, toUserIdList, systemMessageDto);
    }

    @Override
    public void sendBuyerPushMystemMessage(int pushWay, List<Integer> toUserIdList, SystemMessageProxyDto systemMessageProxyDto) {
        SystemMessageDto systemMessageDto = new SystemMessageDto();
        ObjectUtils.fastCopy(systemMessageProxyDto, systemMessageDto);
        messageService.sendBuyerPushMystemMessage(pushWay, toUserIdList, systemMessageDto);
    }

    @Override
    public void sendBuyActivityCouponMessage(String orderNo, Integer operationUserId, Date operationTime) {
        BuyRewardActivityMessageModel jmsMessageModel = new BuyRewardActivityMessageModel();
        if (ObjectUtils.isNullOrEmpty(operationTime)) {
            operationTime = new Date();
        }
        jmsMessageModel.setOperationUserId(operationUserId);
        jmsMessageModel.setNowTime(operationTime);
        jmsMessageModel.setOrderNo(orderNo);
        jmsMessageModel.setGiftType(SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON);
        buyRewardActivityMessageSender.sendMessage(jmsMessageModel);
    }

	@Override
	public void sendRefundMessage(Integer userId,String saleOrderNo, long refundAmount) {
		messageService.sendRefundMessage(userId,saleOrderNo,refundAmount);
	}

	@Override
	public void sendPreferenceMessage(int user, List<Integer> userIdList, String messageTitle, String messageIntro,
			String publishObject) {
		messageService.sendPreferenceMessage(user, userIdList, messageTitle, messageIntro, publishObject);;
		
	}
}
