package com.yldbkd.www.buyer.android.bean;

/**
 * 消息数据类型
 * <p/>
 * Created by linghuxj on 15/10/15.
 */
public class Message extends BaseModel {
    /**
     * 消息类型名称
     */
    private String typeName;
    /**
     * 用户消息类型值 1-优惠消息  2-退款消息  3-活动消息
     */
    private Integer typeValue;
    /**
     * 消息时间
     */
    private String msgTime;
    /**
     * 最新消息内容摘要
     */
    private String msgAbstract;

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getTypeValue() {
        return typeValue;
    }

    public void setTypeValue(Integer typeValue) {
        this.typeValue = typeValue;
    }

    public String getMsgTime() {
        return msgTime;
    }

    public void setMsgTime(String msgTime) {
        this.msgTime = msgTime;
    }

    public String getMsgAbstract() {
        return msgAbstract;
    }

    public void setMsgAbstract(String msgAbstract) {
        this.msgAbstract = msgAbstract;
    }
}
