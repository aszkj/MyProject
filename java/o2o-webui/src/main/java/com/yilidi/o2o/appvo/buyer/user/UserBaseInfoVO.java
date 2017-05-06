package com.yilidi.o2o.appvo.buyer.user;

import java.util.Date;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 用户信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class UserBaseInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -8108924925074100896L;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 用户姓名
     */
    private String userName;
    /**
     * 用户图片URL
     */
    private String userImageUrl;
    /**
     * 会员类型,0-普通会员,1-铂金会员
     */
    private Integer memberType;
    /**
     * 会员过期日期,格式:yyyy-MM-dd
     */
    private String vipExpireDate;
    /**
     * 用户昵称
     */
    private String nickName;
    /**
     * 用户性别： 1：男（默认） 2：女
     */
    private Integer userSex;
    /**
     * 用户生日
     */
    private Date birthday;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public Integer getMemberType() {
        return memberType;
    }

    public void setMemberType(Integer memberType) {
        this.memberType = memberType;
    }

    public String getVipExpireDate() {
        return vipExpireDate;
    }

    public void setVipExpireDate(String vipExpireDate) {
        this.vipExpireDate = vipExpireDate;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Integer getUserSex() {
        return userSex;
    }

    public void setUserSex(Integer userSex) {
        this.userSex = userSex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

}
