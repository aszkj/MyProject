package com.yldbkd.www.buyer.android.bean;

import java.util.Map;

/**
 * 通知数据传输信息
 * <p/>
 * Created by linghuxj on 16/8/5.
 */
public class NotificationBean extends BaseModel {
    /**
     * 通知类型
     */
    private String pushMsgType;
    /**
     * 通知数据：其中数据以key=value的形式组成，多个用“,”来分割
     */
    private Map<String, Object> contentVariablesMap;

    public String getPushMsgType() {
        return pushMsgType;
    }

    public void setPushMsgType(String pushMsgType) {
        this.pushMsgType = pushMsgType;
    }

    public Map<String, Object> getContentVariablesMap() {
        return contentVariablesMap;
    }

    public void setContentVariablesMap(Map<String, Object> contentVariablesMap) {
        this.contentVariablesMap = contentVariablesMap;
    }
}
