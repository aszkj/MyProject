package com.yilidi.o2o.user.proxy.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 用户与APP客户端Token关联关系代理DTO
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午6:44:54
 */
public class UserClientTokenProxyDto extends BaseDto {

    private static final long serialVersionUID = -8965932094604804559L;

    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 用户ID, 关联用户域U_USER表的ID
     */
    private Integer userId;

    /**
     * APP客户端Token
     */
    private String clientToken;

    /**
     * iOS客户端deviceToken
     */
    private String deviceToken;

    /**
     * APP客户端所属平台（CHANNELTYPE_ANDROID 或 CHANNELTYPE_IOS）
     */
    private String platform;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getClientToken() {
        return clientToken;
    }

    public void setClientToken(String clientToken) {
        this.clientToken = clientToken;
    }

    public String getDeviceToken() {
        return deviceToken;
    }

    public void setDeviceToken(String deviceToken) {
        this.deviceToken = deviceToken;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

}
