package com.yldbkd.www.buyer.android.service;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.preference.PreferenceManager;
import android.text.TextUtils;

import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.SplashActivity;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.NotificationBean;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.PreferenceUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 推送相关工具类
 * <p/>
 * Created by linghuxj on 16/8/1.
 */
public class GTUtils {
    private static final String NOTIFY_MESSAGE_DIRECT_TYPE = "directType";
    private static final String NOTIFY_MESSAGE_TITLE = "msgTitle";
    private static final String NOTIFY_MESSAGE_ABSTRACT = "msgAbstract";
    private static final String NOTIFY_MESSAGE_TIME = "msgTime";

    private static HttpBack<BaseModel> saveHttpBack = new HttpBack<BaseModel>() {
        @Override
        public void onSuccess(BaseModel baseModel) {
        }

        @Override
        public void onFailure(String msg) {
            setClientId(null);
        }

        @Override
        public void onTimeOut() {
            setClientId(null);
        }
    };

    /**
     * 保存该手机推送的唯一标识符
     *
     * @param clientId 唯一标识符
     */
    public static void saveClientId(String clientId) {
        if (TextUtils.isEmpty(clientId)) {
            return;
        }
        String oldClientId = getClientId();
        if (clientId.equals(oldClientId)) {
            return;
        }
        setClientId(clientId);
        if (UserUtils.isLogin()) {
            synchronizedClientId();
        } else {
            setClientId(null);
        }
    }

    /**
     * 同步手机推送唯一标识符到服务器
     */
    public static void synchronizedClientId() {
        String clientId = getClientId();
        if (TextUtils.isEmpty(clientId)) {
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("clientId", clientId);
        RetrofitUtils.getInstance().saveClientId(ParamUtils.getParam(map), saveHttpBack);
    }

    /**
     * 获取本地保存的推送唯一标识符
     */
    public static String getClientId() {
        BuyerApp app = BuyerApp.getInstance();
        String clientId = app.getClientId();
        if (clientId == null) {
            clientId = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.Service.CLIENT_ID, null);
            app.setClientId(clientId);
        }
        return clientId;
    }

    /**
     * 保存该手机推送的唯一标识符到本地
     *
     * @param clientId 唯一标识符
     */
    private static void setClientId(String clientId) {
        BuyerApp app = BuyerApp.getInstance();
        app.setClientId(clientId);
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        editor.putString(PreferenceName.Service.CLIENT_ID, clientId);
        editor.apply();
    }

    public static void notifyResult(String notificationParam) {
        if (TextUtils.isEmpty(notificationParam)) {
            return;
        }
        Gson gson = new Gson();
        NotificationBean notification = gson.fromJson(notificationParam, NotificationBean.class);
        if (!TextUtils.isEmpty(notification.getPushMsgType())) {
            Integer directType = (Integer) notification.getContentVariablesMap().get(NOTIFY_MESSAGE_DIRECT_TYPE);
            String msgTitle = (String) notification.getContentVariablesMap().get(NOTIFY_MESSAGE_TITLE);
            String msgAbstract = (String) notification.getContentVariablesMap().get(NOTIFY_MESSAGE_ABSTRACT);
            String msgTime = (String) notification.getContentVariablesMap().get(NOTIFY_MESSAGE_TIME);
            notifyReceiverOrder(directType, msgTitle, msgAbstract, msgTime);
        }
    }

    private static void notifyReceiverOrder(Integer type, String title, String content, String time) {
        notifyMessage(type, content, title, content, time, null);
    }

    /**
     * 组装通知栏并推送
     */
    private static void notifyMessage(Integer type, String ticker, String title, String content, String time, Uri soundUri) {
        BuyerApp app = BuyerApp.getInstance();
        Context context = app.getApplicationContext();
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        Notification.Builder builder = new Notification.Builder(context);

        Intent intent = new Intent(context, SplashActivity.class);
        intent.putExtra(Constants.BundleName.IS_NOTIFICATION, true);
        intent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP); // 该标志为如果所请求的activity在栈顶，则无需创建新的实例

        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT);

        builder.setSmallIcon(R.mipmap.buyer_logo).setLargeIcon(BitmapFactory.decodeResource(
                app.getResources(), R.mipmap.buyer_logo)).setTicker(ticker).setContentIntent(pendingIntent)
                .setAutoCancel(true).setContentText(content).setContentTitle(title).setWhen(System.currentTimeMillis());

        if (soundUri != null) {
            builder.setSound(soundUri);
        }
        notificationManager.notify(0, builder.build());
    }
}
