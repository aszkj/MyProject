/**
 * 文件名称：User.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：用户 实体类，映射数据库表 YiLiDiUserCenter.U_USER <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class User extends BaseModel {

    private static final long serialVersionUID = 1638391137727845730L;

    /**
     * 用户ID，自增主键
     */
    private Integer id;

    /**
     * 客户ID， 管理用户域表U_CUSTOMER的CUSTOMER字段，标识该用户属于那个客户
     */
    private Integer customerId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 电子邮箱
     */
    private String email;

    /**
     * 电话号码
     */
    private String phone;

    /**
     * 所在部门
     */
    private String department;

    /**
     * 密码
     */
    private String password;

    /**
     * 主帐号标识，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERMASTERFLAG)
     */
    private String masterFlag;

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
     * 审核意见
     */
    private String auditNote;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 修改人ID
     */
    private Integer modifyUserId;
    /**
     * 冻结时间
     */
    private Date freezeTime;
    /**
     * 备注信息
     */
    private String note;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
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

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getRegisterPlatform() {
        return registerPlatform;
    }

    public void setRegisterPlatform(String registerPlatform) {
        this.registerPlatform = registerPlatform;
    }

	public Date getFreezeTime() {
		return freezeTime;
	}

	public void setFreezeTime(Date freezeTime) {
		this.freezeTime = freezeTime;
	}

}