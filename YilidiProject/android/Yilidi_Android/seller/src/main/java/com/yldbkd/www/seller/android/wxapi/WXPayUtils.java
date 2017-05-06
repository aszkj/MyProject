package com.yldbkd.www.seller.android.wxapi;

import android.content.Context;
import android.os.Handler;

import com.tencent.mm.sdk.modelpay.PayReq;
import com.tencent.mm.sdk.openapi.IWXAPI;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.yldbkd.www.seller.android.utils.Logger;
import com.yldbkd.www.library.android.pay.AliPayUtils;

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
        payReq.appId = appId;
        payReq.partnerId = payInfo.getPartnerid();
        payReq.prepayId = payInfo.getPrepayid();
        payReq.packageValue = payInfo.getPackagevalue();
        payReq.nonceStr = payInfo.getNoncestr();
        payReq.timeStamp = payInfo.getTimestamp();
        payReq.sign = payInfo.getSign();
        boolean flag = msgApi.sendReq(payReq);
        if(!flag){
            handler.sendEmptyMessage(AliPayUtils.PAY_FAILURE);
        }
        Logger.d("微信支付发起成功：" + flag);
    }
}
