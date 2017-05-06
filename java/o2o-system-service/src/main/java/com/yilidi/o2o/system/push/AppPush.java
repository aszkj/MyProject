package com.yilidi.o2o.system.push;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.gexin.rp.sdk.base.IPushResult;
import com.gexin.rp.sdk.base.impl.SingleMessage;
import com.gexin.rp.sdk.base.impl.Target;
import com.gexin.rp.sdk.base.payload.APNPayload;
import com.gexin.rp.sdk.http.IGtPush;
import com.gexin.rp.sdk.template.TransmissionTemplate;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.StringUtils;

public class AppPush {
    
    private static Logger logger = Logger.getLogger(AppPush.class);

	private static final String NOTIFY_RECEIVER_ORDER_TYPE = "NReceiverOrder";
	private static final String NOTIFY_RECEIVER_ORDER_KEY1 = "count";
	private static final String NOTIFY_RECEIVER_ORDER_SOUND = "new_order_tips.m4a";
	private static final String NOTIFY_TITLE = "一里递";
	
	private static final int ANDROID = 1;
	private static final int IOS = 1;
	
	private static String appId = "k8mcsoh71y5anQ9JrouZi6";
	private static String appKey = "cStr4aDsOy8XMLtraYBs0A";
	private static String masterSecret = "RWi0Fn3b1s6Dnm5IyIFbS1";
	private static String url = "http://sdk.open.api.igexin.com/apiex.htm";

	public void sendNotification(NotificationParam param, Integer platform, String clientToken){
		IGtPush push = new IGtPush(url, appKey, masterSecret);
		SingleMessage message = new SingleMessage();
		message.setData(getTemplate(param));
		IPushResult ret = null;
		if(platform == ANDROID){
			Target target = new Target();
			target.setAppId(appId);
			target.setClientId(clientToken);
			ret = push.pushMessageToSingle(message, target);
		}else if(platform == IOS){
			ret = push.pushAPNMessageToSingle(appId, clientToken, message);
		}
		
		logger.info(ret.getResponse().toString());
	}

	private TransmissionTemplate getTemplate(NotificationParam param) {
		TransmissionTemplate template = new TransmissionTemplate();
		template.setAppId(appId);
		template.setAppkey(appKey);
		template.setTransmissionContent(JsonUtils.toJsonString(param));
		template.setTransmissionType(2);
		// iOS推送相关
		APNPayload apnPayload = new APNPayload();
		apnPayload.setAutoBadge("+1");
		apnPayload.setContentAvailable(1);
		apnPayload.setSound(getIOSNotificationSound(param));
		apnPayload.setAlertMsg(getDictionaryAlertMsg(getIOSNotificationContent(param)));
		apnPayload.addCustomMsg("notificationType", param.getNotificationType());
		apnPayload.addCustomMsg("notificationData", param.getNotificationData());
		template.setAPNInfo(apnPayload);
		return template;
	}

	private String getIOSNotificationContent(NotificationParam param) {
		switch (param.getNotificationType()) {
		case NOTIFY_RECEIVER_ORDER_TYPE:
			return "老板，您有"+param.getDataMap().get(NOTIFY_RECEIVER_ORDER_KEY1)+"个新订单，请尽快处理。";
		default:
			return null;
		}
	}
	
	private String getIOSNotificationSound(NotificationParam param) {
		switch (param.getNotificationType()) {
		case NOTIFY_RECEIVER_ORDER_TYPE:
			return NOTIFY_RECEIVER_ORDER_SOUND;
		default:
			return null;
		}
	}

	private APNPayload.DictionaryAlertMsg getDictionaryAlertMsg(String content) {
		APNPayload.DictionaryAlertMsg alertMsg = new APNPayload.DictionaryAlertMsg();
		alertMsg.setBody(content);
		alertMsg.setTitle(NOTIFY_TITLE);
		return alertMsg;
	}

	/**
	 * 通知传递数据类
	 */
	public class NotificationParam {

	    private static final String DATA_SPLIT_FLAG = ",";
	    private static final String VALUE_SPLIT_FLAG = "=";
		
		/**
		 * 通知类型
		 */
		private String notificationType;
		/**
		 * 某种通知类型下所需要传递的数据（以Key=Value的形式进行组装，多个参数以“,”进行分割）
		 */
		private String notificationData;

		public String getNotificationType() {
			return notificationType;
		}

		public void setNotificationType(String notificationType) {
			this.notificationType = notificationType;
		}

		public String getNotificationData() {
			return notificationData;
		}

		public void setNotificationData(String notificationData) {
			this.notificationData = notificationData;
		}
		
		public Map<String, String> getDataMap(){
			Map<String, String> map = new HashMap<>();
	        if (StringUtils.isBlank(notificationData)) {
	            return map;
	        }
	        String[] datas = notificationData.split(DATA_SPLIT_FLAG);
	        for (String data : datas) {
	            if (data.contains(VALUE_SPLIT_FLAG)) {
	                String[] mapStr = data.split(VALUE_SPLIT_FLAG);
	                map.put(mapStr[0], mapStr[1]);
	            }
	        }
	        return map;
		}
	}
}
