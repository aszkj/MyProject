package com.yilidi.o2o.core.model;

import java.util.List;
import java.util.Map;

/**
 * APP推送消息抽象实体类
 * 
 * @author: chenlian
 * @date: 2016年8月8日 上午10:05:59
 */
public abstract class PushMessageModel extends JmsMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 1L;

    /**
     * 推送消息接收者的用户IDList
     */
    protected List<Integer> toUserIdList;

    /**
     * 推送内容模版名称在push-message.properties配置文件中的属性Key值
     */
    protected String contentTemplateNamePropertiesKey;

    /**
     * 推送消息变量参数Map
     */
    protected Map<String, String> contentVariablesMap;

    /**
     * 语音变量参数
     */
    protected String soundVariable;

    /**
     * 推送消息类型
     */
    protected String pushMsgType;

    /**
     * 推送消息提供方类型
     */
    protected String pushProvideType;

    /**
     * 推送消息通知主键ID列表，用于MQ的接收方在发送推送后，更新S_SMS_NOTIFY_MESSAGE表里原先插入的数据
     */
    protected List<Integer> pushNotifyMessageIdList;

    public List<Integer> getToUserIdList() {
        return toUserIdList;
    }

    public void setToUserIdList(List<Integer> toUserIdList) {
        this.toUserIdList = toUserIdList;
    }

    public String getContentTemplateNamePropertiesKey() {
        return contentTemplateNamePropertiesKey;
    }

    public void setContentTemplateNamePropertiesKey(String contentTemplateNamePropertiesKey) {
        this.contentTemplateNamePropertiesKey = contentTemplateNamePropertiesKey;
    }

    public Map<String, String> getContentVariablesMap() {
        return contentVariablesMap;
    }

    public void setContentVariablesMap(Map<String, String> contentVariablesMap) {
        this.contentVariablesMap = contentVariablesMap;
    }

    public String getSoundVariable() {
        return soundVariable;
    }

    public void setSoundVariable(String soundVariable) {
        this.soundVariable = soundVariable;
    }

    public String getPushMsgType() {
        return pushMsgType;
    }

    public void setPushMsgType(String pushMsgType) {
        this.pushMsgType = pushMsgType;
    }

    public String getPushProvideType() {
        return pushProvideType;
    }

    public void setPushProvideType(String pushProvideType) {
        this.pushProvideType = pushProvideType;
    }

    public List<Integer> getPushNotifyMessageIdList() {
        return pushNotifyMessageIdList;
    }

    public void setPushNotifyMessageIdList(List<Integer> pushNotifyMessageIdList) {
        this.pushNotifyMessageIdList = pushNotifyMessageIdList;
    }

}
