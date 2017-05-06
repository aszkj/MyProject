package com.yilidi.o2o.user.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(邀请用户DTO)
 * @author: chenlian
 * @date: 2016年6月15日 下午5:45:41
 */
public class InvitationUserDto extends BaseDto {

    private static final long serialVersionUID = -6764772039833458287L;

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
