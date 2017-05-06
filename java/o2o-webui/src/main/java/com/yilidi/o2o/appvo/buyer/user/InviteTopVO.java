package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 分享送好礼邀请排行榜
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class InviteTopVO extends AppBaseVO {

    private static final long serialVersionUID = 5587380316172764988L;

    /**
     * 用户头像URL
     */
    private String userImageUrl;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 邀请成功人数
     */
    private Integer inviteCount;

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getInviteCount() {
        return inviteCount;
    }

    public void setInviteCount(Integer inviteCount) {
        this.inviteCount = inviteCount;
    }

}
