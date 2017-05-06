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
import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.core.model.PushSystemMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.message.IPushService;
import com.yilidi.o2o.system.push.getui.PushGetuiUtils;
import com.yilidi.o2o.system.push.getui.model.PushInfos;
import com.yilidi.o2o.system.service.IPushNotifyMessageService;
import com.yilidi.o2o.system.service.dto.PushNotifyMessageDto;
import com.yilidi.o2o.user.proxy.IUserClientTokenProxyService;
import com.yilidi.o2o.user.proxy.dto.UserClientTokenProxyDto;

import freemarker.template.Configuration;
import freemarker.template.Template;

/**
 * 发送推送Service服务类
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午6:37:56
 */
public class YiLiDiPushService implements IPushService {

    private Logger logger = Logger.getLogger(this.getClass());

    private IPushNotifyMessageService pushNotifyMessageService;

    private Configuration freemarkerConfiguration;

    private IUserClientTokenProxyService userClientTokenProxyService;

    @Override
    public void sendPushOrderMessage(PushMessageModel push) {
        try {
            Template template = freemarkerConfiguration.getTemplate(
                    InitConfig.pushMessageConfigParams.get(push.getContentTemplateNamePropertiesKey()),
                    CommonConstants.UTF_8);
            List<Integer> toUserIdList = push.getToUserIdList();
            List<PushInfos> pushInfosList = null;
            PushInfos pushInfos = null;
            if (!ObjectUtils.isNullOrEmpty(toUserIdList)) {
                if (toUserIdList.size() > 0) {
                	pushInfosList = new ArrayList<>();
                	for (Integer userId : toUserIdList) {
                		Map<String, String> contentVariablesMap = push.getContentVariablesMap();
                        String content = FreeMarkerTemplateUtils.processTemplateIntoString(template, contentVariablesMap);
                        UserClientTokenProxyDto userClientTokenProxyDto = userClientTokenProxyService.loadByUserId(userId);
                        if (null == userClientTokenProxyDto) {
                        	logger.info("无法获取到clientToken");
                        	continue;
                        }
                        pushInfos = new PushInfos();
                        pushInfos.setPushMsgType(push.getPushMsgType());
                        pushInfos.setContent(content);
                        pushInfos.setSoundVariable(push.getSoundVariable());
                        pushInfos.setClientToken(userClientTokenProxyDto.getClientToken());
                        pushInfos.setPlatform(userClientTokenProxyDto.getPlatform());
                        pushInfos.setDeviceToken(userClientTokenProxyDto.getDeviceToken());
                        pushInfosList.add(pushInfos);
					}
                	//参数类通
                	if(!ObjectUtils.isNullOrEmpty(pushInfosList)){
                		Map<String, Object> resultMap = PushGetuiUtils.sendSellerNotification(pushInfosList,1);
                		if(!ObjectUtils.isNullOrEmpty(resultMap)){
                			this.updateSendStatus(push.getPushNotifyMessageIdList(), resultMap);
                		}
                	}
//                	logger.info("调用发送推送接口成功, 推送接受人ID：" + userId);
                    
                }
            }
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "发送推送异常" : e.getMessage();
            logger.error(msg, e);
            throw new MessageException(msg);
        }
    }
    
    //推送卖家系统消息
    @Override
	public void sendSellerPushSystemMessage(PushSystemMessageModel push) {
    	try {
    		List<PushInfos> pushInfosList = this.getPushInfos(push);
            Map<String, Object> resultMap = null;
        	if(!ObjectUtils.isNullOrEmpty(pushInfosList)){
        		resultMap = PushGetuiUtils.sendSellerNotification(pushInfosList,push.getPushWay());
        		if(!ObjectUtils.isNullOrEmpty(resultMap)){
        			this.updateSendStatus(push.getPushNotifyMessageIdList(), resultMap);
        		}
//        		logger.info("调用发送推送接口成功, 推送接受人ID：" + userId);
        	}
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "发送推送异常" : e.getMessage();
            logger.error(msg, e);
            throw new MessageException(msg);
        }
		
	}
    //推送买家系统消息
	@Override
	public void sendBuyerPushSystemMessage(PushSystemMessageModel push) {
		try {
        	List<PushInfos> pushInfosList = this.getPushInfos(push);
        	Map<String, Object> resultMap = null;
        	if(!ObjectUtils.isNullOrEmpty(pushInfosList)){
        		resultMap = PushGetuiUtils.sendBuyerNotification(pushInfosList,push.getPushWay());
        		if(!ObjectUtils.isNullOrEmpty(resultMap)){
        			this.updateSendStatus(push.getPushNotifyMessageIdList(), resultMap);
        		}
//        		logger.info("调用发送推送接口成功, 推送接受人ID：" + userId);
        	}
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "发送推送异常" : e.getMessage();
            logger.error(msg, e);
            throw new MessageException(msg);
        }
	}
    //封装推送数据
    private List<PushInfos> getPushInfos(PushSystemMessageModel push) {
    	List<PushInfos> pushInfosList = null;
    	PushInfos pushInfos = null;
    	List<Integer> toUserIdList = push.getToUserIdList();
    	if (!ObjectUtils.isNullOrEmpty(toUserIdList)) {
            if (toUserIdList.size() > 0) {
            	pushInfosList = new ArrayList<>();
            	for (Integer userId : toUserIdList) {
            		UserClientTokenProxyDto userClientTokenProxyDto = userClientTokenProxyService.loadByUserId(userId);
            		if (null == userClientTokenProxyDto) {
            			logger.info("通过userId:"+userId+"无法获取到clientToken");
            			continue;
            		}
            		pushInfos = new PushInfos();
            		pushInfos.setPushMsgType(push.getPushMsgType());
            		pushInfos.setContent(push.getContent());
            		pushInfos.setClientToken(userClientTokenProxyDto.getClientToken());
            		pushInfos.setPlatform(userClientTokenProxyDto.getPlatform());
            		pushInfos.setDeviceToken(userClientTokenProxyDto.getDeviceToken());
            		pushInfos.setSoundVariable("default");
            		pushInfosList.add(pushInfos);
            	}
            }
    	}
    	return pushInfosList;
	}

	private void updateSendStatus(List<Integer> pushNotifyMessageIdList, Map<String, Object> resultMap) {
        List<PushNotifyMessageDto> pushNotifyMessageDtoList = new ArrayList<PushNotifyMessageDto>(
                pushNotifyMessageIdList.size());
        for (Integer pushNotifyMessageId : pushNotifyMessageIdList) {
            PushNotifyMessageDto pushNotifyMessageDto = new PushNotifyMessageDto();
            pushNotifyMessageDto.setId(pushNotifyMessageId);
            if (Result.OK.getValue().equals((String) resultMap.get("result"))) {
                pushNotifyMessageDto.setPushJobId((String) resultMap.get("taskId"));
                pushNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_SUCCEED);
                pushNotifyMessageDto.setFailureReason(null);
            } else {
                pushNotifyMessageDto.setPushJobId(null);
                pushNotifyMessageDto.setMessageStatus(SystemContext.SystemDomain.NOTIFYMSGSTATUS_FAILED);
                Result result = Result.getEnum((String) resultMap.get("result"));
                if (null != result) {
                    pushNotifyMessageDto.setFailureReason(result.getText());
                }
            }
            pushNotifyMessageDtoList.add(pushNotifyMessageDto);
        }
        pushNotifyMessageService.updateSendStatus(pushNotifyMessageDtoList);
		
	}

    public static enum Result {
        OK("ok", "成功"), SUCCESSED_IGNORE("successed_ignore", "无效用户，消息丢弃"), FAILED("failed", "将cid列表加入黑名单失败"), INVALIDCIDLIST(
                "invalidCidList", "无效的cid列表"), STOPTASKERROR("StopTaskError", "停止任务失败"), NOTINDEALRANGE("NotInDealRange",
                "该任务不在停止任务的范围内"), ERROR("Error", "请求信息填写有误"), APPIDERROR("AppidError", "clientid绑定的appid与推送的appid不符"), APPKEYERROR(
                "AppKeyError", "Appkey填写错误"), SIGN_ERROR("sign_error", "Appkey与ClientId不匹配，鉴权失败"), DOMAIN_ERROR(
                "domain_error", "填写的域名错误或者无法解析"), ACTION_ERROR("action_error", "未找到对应的action动作"), PUSHTOTALNUMOVERLIMIT(
                "PushTotalNumOverLimit", "推送消息个数总数超限"), TOKENMD5NOUSERS("TokenMD5NoUsers", "在系统中未查找到用户"), TARGETLISTISNULLORSIZEIS0(
                "TargetListIsNullOrSizeIs0", "目标用户列表为空"), TASKIDNULLERROR("taskIdNullError", "任务Id为空"), SERVICEERROR(
                "ServiceError！", "service错误"), APPIDNOAPPSECRET("AppidNoAppSecret", "appId没有对应的appSecret"), APPIDNOMATCHAPPKEY(
                "AppidNoMatchAppKey", "appid未找到对应的appkey"), TASKIDNOTMATCHAPPKEY("TaskIdNotMatchAppKey",
                "taskId找不到对应的appKey"), NULLMSGCOMMON("NullMsgCommon", "未找到消息公共体"), PUSHMSGTOLISTTIMESOVERLIMIT(
                "PushMsgToListTimesOverLimit", "群推消息次数超限"), PUSHMSGTOAPPTIMESOVERLIMIT("PushMsgToAppTimesOverLimit",
                "群推消息次数超限"), SENDERROR("SendError", "消息发送失败"), SYNSENDERROR("SynSendError", "报文发送错误"), ONLINE("Online", "在线"), OFFLINE(
                "Offline", "离线"), NOBIND("Nobind", "cid未绑定appid"), FLOWEXCEEDED("FlowExceeded", "接口消息推送流量已超限"), BLACKAPPID(
                "BlackAppId", "appId为黑名单"), TOKENMD5ERROR("TokenMD5Error", "cid填写错误"), TAGSNOUSERS("TagsNoUsers",
                "标签找不到对应用户"), APPIDNOUSERS("AppIdNoUsers", "appid下找不到对应用户"), NOSUCHTASKID("NoSuchTaskId", "无效contentid"), OVERLIMIT(
                "OverLimit", "每个clientId在24小时内只能设置一次"), PARSEPUSHINFOERROR("ParsePushInfoError", "pushinfo消息格式有误"), DEVICETOKENERROR(
                "DeviceTokenError", "无效devicetoken"), NOTARGETDEVICETOKEN("NoTargetDeviceToken", "没有填写devicetoken"), NOTARGET(
                "NOTarget", "没有推送目标"), TAGINVALIDORNOAUTH("TagInvalidOrNoAuth", "无效的变迁或没鉴权"), ALIASNOTBIND("AliasNotBind",
                "别名没有绑定"), OTHERERROR("OtherError", "未知错误，无法判定错误类型");

        private final String value;
        private final String text;

        private Result(String value, String text) {
            this.value = value;
            this.text = text;
        }

        public String getValue() {
            return value;
        }

        public String getText() {
            return text;
        }

        public static Result getEnum(String value) {
            if (value != null) {
                Result[] values = Result.values();
                for (Result val : values) {
                    if (val.getValue().equals(value)) {
                        return val;
                    }
                }
            }
            return null;
        }
    }

    public IPushNotifyMessageService getPushNotifyMessageService() {
        return pushNotifyMessageService;
    }

    public void setPushNotifyMessageService(IPushNotifyMessageService pushNotifyMessageService) {
        this.pushNotifyMessageService = pushNotifyMessageService;
    }

    public Configuration getFreemarkerConfiguration() {
        return freemarkerConfiguration;
    }

    public void setFreemarkerConfiguration(Configuration freemarkerConfiguration) {
        this.freemarkerConfiguration = freemarkerConfiguration;
    }

    public IUserClientTokenProxyService getUserClientTokenProxyService() {
        return userClientTokenProxyService;
    }

    public void setUserClientTokenProxyService(IUserClientTokenProxyService userClientTokenProxyService) {
        this.userClientTokenProxyService = userClientTokenProxyService;
    }

}
