package com.yldbkd.www.buyer.android.service;

import android.content.Context;

import com.igexin.sdk.GTIntentService;
import com.igexin.sdk.PushManager;
import com.igexin.sdk.message.GTCmdMessage;
import com.igexin.sdk.message.GTTransmitMessage;
import com.yldbkd.www.buyer.android.utils.Logger;

/**
 * @author lizhg
 * @version $Rev$
 * @time 2017/3/18 14:10
 * @des 接收推送服务事件
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class PushIntentService extends GTIntentService {
    @Override
    public void onReceiveServicePid(Context context, int i) {

    }

    @Override
    public void onReceiveClientId(Context context, String s) {
        GTUtils.saveClientId(s);
    }

    @Override
    public void onReceiveMessageData(Context context, GTTransmitMessage gtTransmitMessage) {
        //获取透传数据
        byte[] payload = gtTransmitMessage.getPayload();
        String taskId = gtTransmitMessage.getTaskId();
        String messageId = gtTransmitMessage.getMessageId();
        // smartPush第三方回执调用接口，actionId范围为90000-90999，可根据业务场景执行
        boolean result = PushManager.getInstance().sendFeedbackMessage(context, taskId, messageId, 90001);
        Logger.d("个人推送 === >  第三方回执接口调用" + (result ? "成功" : "失败"));
        if (payload != null) {
            String data = new String(payload);
            Logger.d("个人推送 === >  receiver payload : " + data);
            GTUtils.notifyResult(data);
        }
    }

    @Override
    public void onReceiveOnlineState(Context context, boolean b) {

    }

    @Override
    public void onReceiveCommandResult(Context context, GTCmdMessage gtCmdMessage) {

    }
}
