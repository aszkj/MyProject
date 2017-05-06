package com.yldbkd.www.seller.android.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import com.igexin.sdk.PushConsts;
import com.igexin.sdk.PushManager;
import com.yldbkd.www.seller.android.utils.Logger;

public class PushReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        Bundle bundle = intent.getExtras();
        Logger.d("个人推送 === >  onReceive() action=" + bundle.getInt("action"));
        Logger.d("个人推送 === >  onReceive() intent=：");
        for (String key : bundle.keySet()) {
            Logger.d("Key=" + key + ", content=" + bundle.getString(key));
        }
        // 现阶段只使用透传和获取clientId
        switch (bundle.getInt(PushConsts.CMD_ACTION)) {
            case PushConsts.GET_MSG_DATA:
                // 获取透传数据
                byte[] payload = bundle.getByteArray("payload");

                String taskId = bundle.getString("taskid");
                String messageId = bundle.getString("messageid");
                // smartPush第三方回执调用接口，actionId范围为90000-90999，可根据业务场景执行
                boolean result = PushManager.getInstance().sendFeedbackMessage(context, taskId, messageId, 90001);
                Logger.d("个人推送 === >  第三方回执接口调用" + (result ? "成功" : "失败"));

                if (payload != null) {
                    String data = new String(payload);
                    Logger.d("个人推送 === >  receiver payload : " + data);
                    ReceiverUtils.notifyResult(data);
                }
                break;
            case PushConsts.GET_CLIENTID:
                // 获取ClientID(CID)
                // 第三方应用需要将CID上传到第三方服务器，并且将当前用户帐号和CID进行关联，以便日后通过用户帐号查找CID进行消息推送
                String cid = bundle.getString("clientid");
                Logger.d("个人推送 === >  clientId = " + cid);
                ReceiverUtils.saveClientId(cid);
                break;
            case PushConsts.GET_SDKONLINESTATE:
            case PushConsts.SET_TAG_RESULT:
            case PushConsts.THIRDPART_FEEDBACK:
            default:
                break;
        }
    }
}
