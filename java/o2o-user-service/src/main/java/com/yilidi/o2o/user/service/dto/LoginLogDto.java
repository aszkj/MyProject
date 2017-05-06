/**
 * 文件名称：LoginLogDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class LoginLogDto extends BaseDto {
    private static final long serialVersionUID = -2184893739375023003L;

    /**
     * 日志记录id，自增主键
     */
    private Integer loginLogId;
    /**
     * 用户登录时的SessionId
     */
    private String sessionId;
    /**
     * 登录用户ID
     */
    private Integer userId;
    /**
     * 用户名
     */
    private String userName;
    /**
     * 客户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
     */
    private String customerType;
    /**
     * 登录时间
     */
    private Date loginTime;
    /**
     * 登录IP
     */
    private String loginIP;
    /**
     * 登录渠道编码，关联系统域系统字典表S_SYSTEM_DICT的DICTCODE字段（DICTTYPE=CHANNELTYPE）
     */
    private String loginChannelCode;
    /**
     * 登出时间
     */
    private Date logoutTime;
    /**
     * 店铺类型
     */
    private String storeType;

    public LoginLogDto(String sessionId, Integer userId, String userName, String customerType, Date loginTime,
            String loginIP, String loginChannelCode) {
        this.sessionId = sessionId;
        this.userId = userId;
        this.userName = userName;
        this.customerType = customerType;
        this.loginTime = loginTime;
        this.loginIP = loginIP;
        this.loginChannelCode = loginChannelCode;
    }

    public LoginLogDto() {
    }

    public Integer getLoginLogId() {
        return loginLogId;
    }

    public void setLoginLogId(Integer loginLogId) {
        this.loginLogId = loginLogId;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

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

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public Date getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(Date loginTime) {
        this.loginTime = loginTime;
    }

    public String getLoginIP() {
        return loginIP;
    }

    public void setLoginIP(String loginIP) {
        this.loginIP = loginIP;
    }

    public String getLoginChannelCode() {
        return loginChannelCode;
    }

    public void setLoginChannelCode(String loginChannelCode) {
        this.loginChannelCode = loginChannelCode;
    }

    public Date getLogoutTime() {
        return logoutTime;
    }

    public void setLogoutTime(Date logoutTime) {
        this.logoutTime = logoutTime;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

}
