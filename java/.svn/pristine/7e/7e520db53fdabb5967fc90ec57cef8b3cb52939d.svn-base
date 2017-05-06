package com.yilidi.o2o.core.model;

import java.util.List;
import java.util.Map;

/**
 * 
 * @Description:TODO(发送短信消息抽象实体类)
 * @author: chenlian
 * @date: 2015年10月29日 下午5:21:44
 * 
 */
public abstract class SmsMessageModel extends JmsMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 1L;

    /**
     * 接收者的手机号List
     */
    protected List<String> toUserMobileList;

    /**
     * 短信内容模版名称在sms-message.properties配置文件中的属性Key值
     */
    protected String contentTemplateNamePropertiesKey;

    /**
     * 短信内容模版中变量参数Map
     */
    protected Map<String, String> contentVariablesMap;

    /**
     * 发送消息的IP地址
     */
    protected String remoteIpAddr;

    /**
     * 短信消息类型
     */
    protected String smsMsgType;

    /**
     * 短信消息提供方类型
     */
    protected String smsProvideType;

    /**
     * 短信消息通知主键ID列表，用于MQ的接收方在发送短信后，更新S_SMS_NOTIFY_MESSAGE表里原先插入的数据
     */
    protected List<Integer> smsNotifyMessageIdList;

    public List<String> getToUserMobileList() {
        return toUserMobileList;
    }

    public void setToUserMobileList(List<String> toUserMobileList) {
        this.toUserMobileList = toUserMobileList;
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

    public String getRemoteIpAddr() {
        return remoteIpAddr;
    }

    public void setRemoteIpAddr(String remoteIpAddr) {
        this.remoteIpAddr = remoteIpAddr;
    }

    public String getSmsMsgType() {
        return smsMsgType;
    }

    public void setSmsMsgType(String smsMsgType) {
        this.smsMsgType = smsMsgType;
    }

    public String getSmsProvideType() {
        return smsProvideType;
    }

    public void setSmsProvideType(String smsProvideType) {
        this.smsProvideType = smsProvideType;
    }

    public List<Integer> getSmsNotifyMessageIdList() {
        return smsNotifyMessageIdList;
    }

    public void setSmsNotifyMessageIdList(List<Integer> smsNotifyMessageIdList) {
        this.smsNotifyMessageIdList = smsNotifyMessageIdList;
    }

}
