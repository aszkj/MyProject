package com.yldbkd.www.seller.android.bean;

/**
 * 邀请用户信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class InvitationUser extends BaseModel {

    /**
     * 遮掩过后的用户手机号码
     */
    private String userMaskMobile;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 铂金会员标识。
     * 见Constants.VIP_LEVEL
     * 0 -	非铂金会员
     * 1 -  铂金会员
     * 2 -  铂金体验会员
     */
    private Integer vipFlag = 0;

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
