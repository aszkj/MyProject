package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 用户信息小表(将部分关键用户信息同步到交易库，便于跨库操作)实体类DTO
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午5:21:41
 */
public class SmallTableUserInfoDto extends BaseDto {

    private static final long serialVersionUID = 4347010780591136197L;

    /**
     * 主键ID
     */
    private Integer id;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 客户ID
     */
    private Integer customerId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 客户名
     */
    private String customerName;

    /**
     * 用户手机号
     */
    private String userMobile;

    /**
     * 客户手机号
     */
    private String customerMobile;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 注册时间
     */
    private Date registerTime;

    /**
     * 邀请码
     */
    private String invitationCode;

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

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public String getCustomerMobile() {
        return customerMobile;
    }

    public void setCustomerMobile(String customerMobile) {
        this.customerMobile = customerMobile;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

}