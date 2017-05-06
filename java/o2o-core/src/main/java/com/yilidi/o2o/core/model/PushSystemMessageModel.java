package com.yilidi.o2o.core.model;

import java.util.List;

/**
 * APP推送消息抽象实体类
 * 
 * @author: zhangkun
 * @date: 2017.3.30
 */
public class PushSystemMessageModel extends JmsMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 1L;

    /**
     * 推送消息接收者的用户IDList
     */
    protected List<Integer> toUserIdList;
    
    /**
     * 推送方式  1.单推;2.多推
     */
    protected int pushWay;
    
    /**
     * 消息内容
     */
    protected String content;

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPushWay() {
		return pushWay;
	}

	public void setPushWay(int pushWay) {
		this.pushWay = pushWay;
	}

}
