package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 分享活动信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class InfoByShareCodeVO extends AppBaseVO {

    private static final long serialVersionUID = 5587380316172764988L;

    /**
     * 分享活动信息
     */
    private ShareContentVO shareInfo;

    /**
     * 邀请人用户信息
     */
    private UserBaseInfoVO inviteUserInfo;

    public ShareContentVO getShareInfo() {
        return shareInfo;
    }

    public void setShareInfo(ShareContentVO shareInfo) {
        this.shareInfo = shareInfo;
    }

    public UserBaseInfoVO getInviteUserInfo() {
        return inviteUserInfo;
    }

    public void setInviteUserInfo(UserBaseInfoVO inviteUserInfo) {
        this.inviteUserInfo = inviteUserInfo;
    }

}
