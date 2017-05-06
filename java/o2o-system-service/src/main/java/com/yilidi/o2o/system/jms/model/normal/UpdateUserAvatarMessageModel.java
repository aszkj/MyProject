package com.yilidi.o2o.system.jms.model.normal;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 用户分享奖励消息
 * 
 * @author: chenbin
 * @date: 2016年5月26日 下午4:24:57
 */
public class UpdateUserAvatarMessageModel extends JmsMessageModel {

    private static final long serialVersionUID = 8587740909273362667L;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 用户头像url
     */
    private String userAvatar;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }

}
