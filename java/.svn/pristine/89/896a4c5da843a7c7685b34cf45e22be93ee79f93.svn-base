package com.yilidi.o2o.system.message;

import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.core.model.PushSystemMessageModel;

/**
 * 推送Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午4:24:27
 */
public interface IPushService {

    /**
     * 发送推送通知消息(订单推送消息)
     * 
     * @param push
     */
    public void sendPushOrderMessage(PushMessageModel push);
    
    /**
     * 发送推送通知消息(卖家系统推送消息)
     * 
     * @param push
     */
    public void sendSellerPushSystemMessage(PushSystemMessageModel push);
    
    /**
     * 发送推送通知消息(买家系统推送消息)
     * 
     * @param push
     */
    public void sendBuyerPushSystemMessage(PushSystemMessageModel push);

}
