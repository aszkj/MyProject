package com.yilidi.o2o.system.push.getui;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.gexin.rp.sdk.base.IBatch;
import com.gexin.rp.sdk.base.IPushResult;
import com.gexin.rp.sdk.base.impl.ListMessage;
import com.gexin.rp.sdk.base.impl.SingleMessage;
import com.gexin.rp.sdk.base.impl.Target;
import com.gexin.rp.sdk.base.payload.APNPayload;
import com.gexin.rp.sdk.http.IGtPush;
import com.gexin.rp.sdk.template.TransmissionTemplate;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.PushException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.push.getui.model.BasePushInfos;
import com.yilidi.o2o.system.push.getui.model.PushInfos;

public class PushGetuiUtils {

    private static Logger logger = Logger.getLogger(PushGetuiUtils.class);

    private static final int TRANSMISSION_TYPE = 2;

    private static final String AUTO_BADGE = "+1";

    private static final int CONTENT_AVAILABLE = 0;

    private static final String SUCCESSED_ONLINE = "successed_online";

    private static final String OK = "ok";
   
    private static ApplyPushGetuiParam applyPushGetuiParam;
    private static ApplyPushGetuiParam BuyerApplyPushGetuiParam = ApplyPushGetuiParam.getBuyerInstance();
    private static ApplyPushGetuiParam SellerApplyPushGetuiParam = ApplyPushGetuiParam.getSellerInstance();
    
    public static Map<String, Object> sendBuyerNotification(List<PushInfos> pushInfosList,int pushWay){
    	applyPushGetuiParam = BuyerApplyPushGetuiParam;
    	return sendNotificationToSingleOrToMultiple(pushInfosList,pushWay);
    }
    public static Map<String, Object> sendSellerNotification(List<PushInfos> pushInfosList,int pushWay){
    	applyPushGetuiParam = SellerApplyPushGetuiParam;
    	return sendNotificationToSingleOrToMultiple(pushInfosList,pushWay);
    }
    
    //判断单推还是多推
    private static Map<String, Object> sendNotificationToSingleOrToMultiple(List<PushInfos> pushInfosList,int pushWay){
    	Map<String, Object> resultMap = null;
    	if(pushWay == 1){
    		resultMap = sendNotificationToSingle(pushInfosList);
    	}else if(pushWay == 2){
    		resultMap = sendNotificationToMultiple(pushInfosList);
    	}
    	return resultMap;
    }
    
    //单推
    private static Map<String, Object> sendNotificationToSingle(List<PushInfos> pushInfosList) throws PushException {
        try {
        	SingleMessage message = null;
        	Target target = null;
        	IPushResult ret = null;
        	Map<String, Object> resultMap = null;
        	IGtPush push = new IGtPush(applyPushGetuiParam.getUrl(), applyPushGetuiParam.getAppKey(), applyPushGetuiParam.getMasterSecret());
        	IBatch batch = push.getBatch();
        	for (PushInfos pushInfos : pushInfosList) {
        		message = new SingleMessage();
        		if (SystemContext.UserDomain.CHANNELTYPE_IOS.equals(pushInfos.getPlatform())) {
        			message.setData(getIosTemplate(pushInfos));
        		}else{
        			message.setData(getAndTemplate(pushInfos));
        		}
        		target = new Target();
        		target.setAppId(applyPushGetuiParam.getAppId());
        		target.setClientId(pushInfos.getClientToken());
        		batch.add(message, target);
			}
        	ret = batch.submit();
    		resultMap = ret.getResponse();
    		logger.info("resultMap : " + JsonUtils.toJsonStringWithDateFormat(resultMap));
            return resultMap;
        } catch (Exception e) {
            String msg = "推送发送接口调用发生异常";
            logger.error(msg, e);
            throw new PushException(msg);
        }
    }
    //多推
    private static Map<String, Object> sendNotificationToMultiple(List<PushInfos> pushInfosList) throws PushException {
        try {
            IGtPush push = new IGtPush(applyPushGetuiParam.getUrl(), applyPushGetuiParam.getAppKey(), applyPushGetuiParam.getMasterSecret());
            IPushResult ret = null;
            Map<String, Object> resultMap = null;
            PushInfos pushInfos = pushInfosList.get(0);
            ListMessage message = null;
            List<Target> andTargetList = new ArrayList<>();
            List<Target> iosTargetList = new ArrayList<>();
//            List<String> deviceTokenList = new ArrayList<>();
            Target target = null;
            for (PushInfos pushInfo : pushInfosList) {
            	target = new Target();
            	target.setAppId(applyPushGetuiParam.getAppId());
            	target.setClientId(pushInfo.getClientToken());
            	if (SystemContext.UserDomain.CHANNELTYPE_IOS.equals(pushInfo.getPlatform())) {
//            		deviceTokenList.add(pushInfo.getDeviceToken());
            		iosTargetList.add(target);
            	}else{
            		andTargetList.add(target);
            	}
			}
            String contentId = "";
            //安卓
            if(!ObjectUtils.isNullOrEmpty(andTargetList)){
            	message = new ListMessage();
            	message.setData(getAndTemplate(pushInfos));
            	contentId = push.getContentId(message);
            	resultMap = push.pushMessageToList(contentId, andTargetList).getResponse();
            }
            //ios
            if(!ObjectUtils.isNullOrEmpty(iosTargetList)){
            	message = new ListMessage();
            	message.setData(getIosTemplate(pushInfos));
            	contentId = push.getContentId(message);
            	resultMap = push.pushMessageToList(contentId, andTargetList).getResponse();
            }
            logger.info("resultMap : " + JsonUtils.toJsonStringWithDateFormat(resultMap));
            return resultMap;
        } catch (Exception e) {
            String msg = "推送发送接口调用发生异常";
            logger.error(msg, e);
            throw new PushException(msg);
        }
    }
    //安卓模板
    private static TransmissionTemplate getAndTemplate(PushInfos pushInfos) {
        TransmissionTemplate template = new TransmissionTemplate();
        template.setAppId(applyPushGetuiParam.getAppId());
        template.setAppkey( applyPushGetuiParam.getAppKey());
        BasePushInfos basePushInfos = new BasePushInfos();
        basePushInfos.setPushMsgType(pushInfos.getPushMsgType());
        Map<String, String> customMsg = new HashMap<String, String>();
        customMsg.put("pushMsgType", pushInfos.getPushMsgType());
        customMsg.put("contentVariablesMap", pushInfos.getContent());
        template.setTransmissionContent(JsonUtils.toJsonStringWithDateFormat(customMsg));
        template.setTransmissionType(TRANSMISSION_TYPE);
        return template;
    }
  //ios模板
    private static TransmissionTemplate getIosTemplate(PushInfos pushInfos) {
        TransmissionTemplate template = new TransmissionTemplate();
        template.setAppId(applyPushGetuiParam.getAppId());
        template.setAppkey( applyPushGetuiParam.getAppKey());
        BasePushInfos basePushInfos = new BasePushInfos();
        basePushInfos.setPushMsgType(pushInfos.getPushMsgType());
        Map<String, String> customMsg = new HashMap<String, String>();
        customMsg.put("pushMsgType", pushInfos.getPushMsgType());
        customMsg.put("contentVariablesMap", pushInfos.getContent());
        template.setTransmissionContent(JsonUtils.toJsonStringWithDateFormat(customMsg));
        template.setTransmissionType(TRANSMISSION_TYPE);
        APNPayload apnPayload = new APNPayload();
        apnPayload.setAutoBadge(AUTO_BADGE);
        apnPayload.setContentAvailable(CONTENT_AVAILABLE);
        apnPayload.setSound(pushInfos.getSoundVariable());
        JSONObject jsonObject = JsonUtils.parseObject(pushInfos.getContent());
        apnPayload.setAlertMsg(getAlertMsg(jsonObject.getString("msgTitle")));
        apnPayload.addCustomMsg("pushMsgType", pushInfos.getPushMsgType());
        apnPayload.addCustomMsg("contentVariablesMap", pushInfos.getContent());
        template.setAPNInfo(apnPayload);
        return template;
    }
    
    private static APNPayload.SimpleAlertMsg getAlertMsg(String content) {
        return new APNPayload.SimpleAlertMsg(content);
    }

    private static boolean isSendSuccessOnline(Map<String, Object> resultMap) {
        return OK.equals((String) resultMap.get("result")) && SUCCESSED_ONLINE.equals((String) resultMap.get("status"));
    }

}
