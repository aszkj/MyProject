package com.yilidi.o2o.user.service.dto;

import java.util.Date;

/**
 * 
 * @Description:TODO(用户DTO)
 * @author: chenlian
 * @date: 2015年11月4日 下午5:10:17
 * 
 */
public class UserDto extends UserBaseDto {

    private static final long serialVersionUID = -4193498954735452666L;
    /**
     * 客户ID， 管理用户域表U_CUSTOMER的CUSTOMER字段，标识该用户属于那个客户
     */
    private Integer customerId;

    /**
     * 真实姓名
     */
    private String realName;
    /**
     * 电子邮箱
     */
    private String email;
    /**
     * 所在部门
     */
    private String department;
    /**
     * 主帐号标识，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERMASTERFLAG)
     */
    private String masterFlag;
    /**
     * 主用户ID
     */
    private Integer masterUserId;
    /**
     * 客户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
     */
    private String customerType;
    /**
     * 用户状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERSTATUS)， 有效/启用 无效/禁用
     */
    private String statusCode;
    /**
     * 审核状态编码，关联系统域系统字典S_SYSTEM_DICT的DICTCODE字段(DICTTYPE=USERAUDITSTATUS)
     */
    private String auditStatusCode;
    /**
     * 用户注册渠道平台：Android,ISO,微信,PC端等,对应S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容
     */
    private String registerPlatform;
    /**
     * 买家用户级别类型
     */
    private String buyerLevelCode;
    /**
     * 会员开通时间
     */
    private Date vipCreateTime;
    /**
     * 会员过期时间
     */
    private Date vipExpireDate;
    /**
     * 买家用户级别类型名称
     */
    private String buyerLevelName;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建人ID
     */
    private Integer createUserId;
    /**
     * 审核时间
     */
    private Date auditTime;
    /**
     * 审核人ID
     */
    private Integer auditUserId;
    /**
     * 审核人姓名
     */
    private String auditUserName;
    /**
     * 审核意见
     */
    private String auditNote;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 冻结时间
     */
    private Date freezeTime;
    /**
     * 修改人ID
     */
    private Integer modifyUserId;
    /**
     * 备注信息
     */
    private String note;
    /**
     * 用户属性DTO
     */
    private UserProfileDto userProfileDto = new UserProfileDto();
    /**
     * 用户关联角色的角色ID字符串
     */
    private String strRoleIds;
    /**
     * 修改密码时，原来的旧密码
     */
    private String oldPassword;
    /**
     * 修改密码时，输入的新密码
     */
    private String newPassword;
    /**
     * 修改密码时，确认的新密码
     */
    private String confirmPassword;
    /**
     * 邀请码
     */
    private String invitationCode;

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
    }

    public Integer getMasterUserId() {
        return masterUserId;
    }

    public void setMasterUserId(Integer masterUserId) {
        this.masterUserId = masterUserId;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getAuditStatusCode() {
        return auditStatusCode;
    }

    public void setAuditStatusCode(String auditStatusCode) {
        this.auditStatusCode = auditStatusCode;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Integer getAuditUserId() {
        return auditUserId;
    }

    public void setAuditUserId(Integer auditUserId) {
        this.auditUserId = auditUserId;
    }

    public String getAuditUserName() {
        return auditUserName;
    }

    public void setAuditUserName(String auditUserName) {
        this.auditUserName = auditUserName;
    }

    public String getAuditNote() {
        return auditNote;
    }

    public void setAuditNote(String auditNote) {
        this.auditNote = auditNote;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public UserProfileDto getUserProfileDto() {
        return userProfileDto;
    }

    public void setUserProfileDto(UserProfileDto userProfileDto) {
        this.userProfileDto = userProfileDto;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getBuyerLevelCode() {
        return buyerLevelCode;
    }

    public void setBuyerLevelCode(String buyerLevelCode) {
        this.buyerLevelCode = buyerLevelCode;
    }

    public Date getVipCreateTime() {
        return vipCreateTime;
    }

    public void setVipCreateTime(Date vipCreateTime) {
        this.vipCreateTime = vipCreateTime;
    }

    public Date getVipExpireDate() {
        return vipExpireDate;
    }

    public void setVipExpireDate(Date vipExpireDate) {
        this.vipExpireDate = vipExpireDate;
    }

    public String getRegisterPlatform() {
        return registerPlatform;
    }

    public void setRegisterPlatform(String registerPlatform) {
        this.registerPlatform = registerPlatform;
    }

    public String getStrRoleIds() {
        return strRoleIds;
    }

    public void setStrRoleIds(String strRoleIds) {
        this.strRoleIds = strRoleIds;
    }

    public String getBuyerLevelName() {
        return buyerLevelName;
    }

    public void setBuyerLevelName(String buyerLevelName) {
        this.buyerLevelName = buyerLevelName;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

	public Date getFreezeTime() {
		return freezeTime;
	}

	public void setFreezeTime(Date freezeTime) {
		this.freezeTime = freezeTime;
	}

}
