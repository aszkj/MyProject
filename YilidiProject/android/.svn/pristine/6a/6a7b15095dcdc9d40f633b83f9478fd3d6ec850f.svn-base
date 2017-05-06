package com.yldbkd.www.seller.android.receiver;

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
import com.yldbkd.www.library.android.common.PreferenceUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.activity.SplashActivity;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.NotificationBean;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.PreferenceName;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 推送相关工具类
 * <p/>
 * Created by linghuxj on 16/8/1.
 */
public class ReceiverUtils {

    private static final String NOTIFY_RECEIVER_ORDER_TYPE = "PUSHNOTIFYMSGTYPE_ORDERACCEPT";
    private static final String NOTIFY_RECEIVER_ORDER_KEY1 = "forAcceptCount";

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
        SellerApp app = SellerApp.getInstance();
        String clientId = app.getClientId();
        if (clientId == null) {
            clientId = PreferenceUtils.getStringPref(app.getApplicationContext(), PreferenceName.Receiver.CLIENT_ID, null);
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
        SellerApp app = SellerApp.getInstance();
        app.setClientId(clientId);
        SharedPreferences sharedpreferences;
        SharedPreferences.Editor editor;
        sharedpreferences = PreferenceManager.getDefaultSharedPreferences(app.getApplicationContext());
        if (sharedpreferences == null) {
            return;
        }
        editor = sharedpreferences.edit();
        editor.putString(PreferenceName.Receiver.CLIENT_ID, clientId);
        editor.apply();
    }

    public static void notifyResult(String notificationParam) {
        if (TextUtils.isEmpty(notificationParam)) {
            return;
        }
        Gson gson = new Gson();
        NotificationBean notification = gson.fromJson(notificationParam, NotificationBean.class);
        switch (notification.getPushMsgType()) {
            case NOTIFY_RECEIVER_ORDER_TYPE:
                String count = notification.getContentVariablesMap().get(NOTIFY_RECEIVER_ORDER_KEY1);
                notifyReceiverOrder(Integer.parseInt(count));
                break;
            default:
                break;
        }
    }

    private static void notifyReceiverOrder(Integer count) {
        Context context = SellerApp.getInstance().getApplicationContext();
        String ticker = context.getString(R.string.notify_receiver_order_ticker);
        String title = context.getString(R.string.notify_receiver_order_title);
        String content = String.format(context.getString(R.string.notify_receiver_order_content), count);
        Uri soundUri = Uri.parse("android.resource://" + context.getPackageName() + "/" + R.raw.new_order_tips);
        notifyMessage(ticker, title, content, soundUri);
    }

    /**
     * 组装通知栏并推送
     */
    private static void notifyMessage(String ticker, String title, String content, Uri soundUri) {
        SellerApp app = SellerApp.getInstance();
        Context context = app.getApplicationContext();
        NotificationManager notificationManager = (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);
        Notification.Builder builder = new Notification.Builder(context);

        Intent notifyIntent = new Intent(context, SplashActivity.class);
        notifyIntent.putExtra(Constants.BundleName.IS_NOTIFICATION, true);
        notifyIntent.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP); // 该标志为如果所请求的activity在栈顶，则无需创建新的实例
        PendingIntent pendingIntent = PendingIntent.getActivity(context, 0, notifyIntent, PendingIntent.FLAG_UPDATE_CURRENT);

        builder.setSmallIcon(R.mipmap.seller_logo).setLargeIcon(BitmapFactory.decodeResource(
                app.getResources(), R.mipmap.seller_notification_logo)).setTicker(ticker).setContentIntent(pendingIntent)
                .setAutoCancel(true).setContentText(content).setContentTitle(title).setWhen(System.currentTimeMillis());

        if (soundUri != null) {
            builder.setSound(soundUri);
        }

        notificationManager.notify(0, builder.build());
    }
}
