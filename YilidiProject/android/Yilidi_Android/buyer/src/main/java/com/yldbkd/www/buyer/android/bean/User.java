package com.yldbkd.www.buyer.android.bean;

/**
 * 用户信息数据
 */
public class User extends BaseModel {

    /**
     * 用户ID
     */
    private int userId;
    /**
     * 用户名称-手机号
     */
    private String userName;
    /**
     * 用户昵称
     */
    private String nickName;
    /**
     * 用户性别 1男  2 女
     */
    private Integer userSex = 1;
    /**
     * 用户生日
     */
    private String birthday;
    /**
     * 用户图片url
     */
    private String userImageUrl;
    /**
     * 会员过期日期 yyyy-MM-dd
     */
    private String vipExpireDate;
    /**
     * 会员类型  0-普通会员  1-铂金会员
     */
    private int memberType;
    /**
     * 是否绑定手机号  0-未绑定  1-绑定
     */
    private Integer binding;
    /**
     * 账户绑定的微信信息
     */
    private WXData bindWXInfo;
    /**
     * 账户绑定的QQ信息
     */
    private QQData bindQQInfo;

    public int getMemberType() {
        return memberType;
    }

    public void setMemberType(int memberType) {
        this.memberType = memberType;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getVipExpireDate() {
        return vipExpireDate;
    }

    public void setVipExpireDate(String vipExpireDate) {
        this.vipExpireDate = vipExpireDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Integer getBinding() {
        return binding;
    }

    public void setBinding(Integer binding) {
        this.binding = binding;
    }

    public Integer getUserSex() {
        return userSex;
    }

    public void setUserSex(Integer userSex) {
        this.userSex = userSex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public WXData getBindWXInfo() {
        return bindWXInfo;
    }

    public void setBindWXInfo(WXData bindWXInfo) {
        this.bindWXInfo = bindWXInfo;
    }

    public QQData getBindQQInfo() {
        return bindQQInfo;
    }

    public void setBindQQInfo(QQData bindQQInfo) {
        this.bindQQInfo = bindQQInfo;
    }
}
