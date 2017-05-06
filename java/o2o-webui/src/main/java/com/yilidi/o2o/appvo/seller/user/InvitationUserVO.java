package com.yilidi.o2o.appvo.seller.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(邀请用户信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:12:47
 */
public class InvitationUserVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 7660622468855396368L;
    /**
     * 遮掩过后的用户手机号码
     */
    private String userMaskMobile;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 铂金会员标识。0 - 非铂金会员 1 - 铂金会员
     */
    private Integer vipFlag;

    public String getUserMaskMobile() {
        return userMaskMobile;
    }

    public void setUserMaskMobile(String userMaskMobile) {
        this.userMaskMobile = userMaskMobile;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getVipFlag() {
        return vipFlag;
    }

    public void setVipFlag(Integer vipFlag) {
        this.vipFlag = vipFlag;
    }
}
