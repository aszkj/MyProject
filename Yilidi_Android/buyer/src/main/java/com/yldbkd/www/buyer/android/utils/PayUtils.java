package com.yldbkd.www.buyer.android.utils;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Handler;
import android.text.TextUtils;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.bean.PayType;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.wxapi.WXPayEntryActivity;
import com.yldbkd.www.buyer.android.wxapi.WXPayInfo;
import com.yldbkd.www.buyer.android.wxapi.WXPayUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pay.AliPayUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 支付工具类
 * <p/>
 * Created by linghuxj on 15/11/21.
 */
public class PayUtils {

    private static PayUtils utils;

    private static HttpBack<String> aliPayHttpBack;
    private static HttpBack<WXPayInfo> wxPayHttpBack;

    private static final int ALI_PAY_MODE = 0x01;
    private static final int WX_PAY_MODE = 0x02;

    private PayUtils() {
    }

    public static PayUtils getInstance(final Activity activity, final Handler handler) {
        if (utils == null) {
            utils = new PayUtils();
        }
        aliPayHttpBack = new HttpBack<String>() {
            @Override
            public void onSuccess(String aliPayInfo) {
                if (TextUtils.isEmpty(aliPayInfo)) {
                    ToastUtils.show(activity, R.string.pay_request_exception);

                    Intent intent = new Intent(activity, MainActivity.class);
                    activity.startActivity(intent);

                    AppManager.getAppManager().finishActivity(activity);

                    return;
                }
                AliPayUtils payUtils = new AliPayUtils(activity, handler);
                payUtils.toPay(aliPayInfo);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                handler.sendEmptyMessage(AliPayUtils.PAY_FAILURE);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                handler.sendEmptyMessage(AliPayUtils.PAY_NETWORK_EXCEPTION);
            }
        };
        wxPayHttpBack = new HttpBack<WXPayInfo>() {
            @Override
            public void onSuccess(WXPayInfo payInfo) {
                if (payInfo == null) {
                    ToastUtils.show(activity, R.string.pay_request_exception);
                    return;
                }
                new PayReceiver(activity, handler).registerAction();
                WXPayUtils.toPay(activity, Constants.WX_APP_ID, payInfo, handler);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                handler.sendEmptyMessage(AliPayUtils.PAY_FAILURE);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                handler.sendEmptyMessage(AliPayUtils.PAY_NETWORK_EXCEPTION);
            }
        };
        return utils;
    }

    public void toPay(Integer payType, String orderNo) {
        switch (payType) {
            case Constants.OnlinePayType.ALI_PAY:
                aliPayRequest(orderNo);
                break;
            case Constants.OnlinePayType.WX_PAY:
                wxPayRequest(orderNo);
                break;
        }
    }

    private void aliPayRequest(String orderNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderNo);
        RetrofitUtils.getInstance(true).getAliPayInfo(ParamUtils.getParam(map), aliPayHttpBack);
    }

    private void wxPayRequest(String orderNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderNo);
        RetrofitUtils.getInstance(true).getWXPayInfo(ParamUtils.getParam(map), wxPayHttpBack);
    }

    static class PayReceiver extends BroadcastReceiver {
        private Context context;
        private Handler payHandler;

        public PayReceiver(Context context, Handler payHandler) {
            this.context = context;
            this.payHandler = payHandler;
        }

        public void registerAction() {
            IntentFilter filter = new IntentFilter();
            filter.addAction(WXPayEntryActivity.ACTION);
            context.registerReceiver(this, filter);
        }

        public void unregister() {
            context.unregisterReceiver(this);
        }

        @Override
        public void onReceive(Context context, Intent intent) {
            int wxPayCode = intent.getExtras().getInt(WXPayEntryActivity.CODE);
            int messageCode = wxPayCode == WXPayEntryActivity.SUCCESS ? AliPayUtils.PAY_SUCCESS :
                    wxPayCode == WXPayEntryActivity.CANCEL ? AliPayUtils.PAY_CANCEL : AliPayUtils.PAY_FAILURE;
            payHandler.sendEmptyMessage(messageCode);
            unregister();
        }
    }

    public static List<PayType> getPayTypes(int payMode) {
        List<PayType> payTypes = new ArrayList<>();
        if ((payMode & ALI_PAY_MODE) == ALI_PAY_MODE) {
            payTypes.add(getPayType(Constants.OnlinePayType.ALI_PAY, Constants.PayTypeName.ALI_PAY_NAME));
        }
        if ((payMode & WX_PAY_MODE) == WX_PAY_MODE) {
            payTypes.add(getPayType(Constants.OnlinePayType.WX_PAY, Constants.PayTypeName.WX_PAY_NAME));
        }
        return payTypes;
    }

    private static PayType getPayType(Integer payTypeCode, String payTypeName) {
        return new PayType(payTypeCode, payTypeName);
    }
}
