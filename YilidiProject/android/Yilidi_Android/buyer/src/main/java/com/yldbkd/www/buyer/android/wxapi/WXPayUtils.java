package com.yldbkd.www.buyer.android.wxapi;

import android.content.Context;
import android.os.Handler;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.library.android.pay.AliPayUtils;
import com.tencent.mm.sdk.modelpay.PayReq;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.WXAPIFactory;

/**
 * 微信支付工具类
 * <p/>
 * Created by linghuxj on 15/10/19.
 */
public class WXPayUtils {

    public static void toPay(final Context context, String appId, WXPayInfo payInfo, Handler handler) {
        if (context == null) {
            return;
        }
        final IWXAPI msgApi = WXAPIFactory.createWXAPI(context, appId, true);
        msgApi.registerApp(appId);

        PayReq payReq = new PayReq();
        payReq.appId = payInfo.getAppId();
        payReq.partnerId = payInfo.getPartnerId();
        payReq.prepayId = payInfo.getPrepayId();
        payReq.packageValue = payInfo.getPackageValue();
        payReq.nonceStr = payInfo.getNonceStr();
        payReq.timeStamp = payInfo.getTimeStamp();
        payReq.sign = payInfo.getSign();
        boolean flag = msgApi.sendReq(payReq);
        if(!flag){
            handler.sendEmptyMessage(AliPayUtils.PAY_FAILURE);
        }
        Logger.d("微信支付发起成功：" + flag);
    }
}
