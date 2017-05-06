package com.yilidi.o2o.sessionmodel.buyer.user;

import java.io.Serializable;

import com.yilidi.o2o.user.service.dto.UserDto;

public class UserSessionModel implements Serializable {

    private static final long serialVersionUID = 1L;

    /** 用户ID ***/
    private Integer userId;

    /**
     * 客户ID， 管理用户域表U_CUSTOMER的CUSTOMER字段，标识该用户属于那个客户
     */
    private Integer customerId;

    /** 用户名称 ***/
    private String userName;
    /*** 用户图片url ***/
    private String userImageUrl;

    public UserSessionModel() {
    }

    public UserSessionModel(UserDto userDto) {
        this.userId = userDto.getId();
        this.customerId = userDto.getCustomerId();
        this.userName = userDto.getUserName();
        this.userImageUrl = userDto.getUserProfileDto().getUserImageUrl();
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
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

}
