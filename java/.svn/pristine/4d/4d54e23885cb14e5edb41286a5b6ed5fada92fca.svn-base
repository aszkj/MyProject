package com.yilidi.o2o.user.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：用户与客户组合类<br/>
 * 作者： llp <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class UserInfo extends BaseModel {
    private static final long serialVersionUID = 4719980854187544065L;
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
     * 名称
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
     * 客户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
     */
    private String customerType;
    /**
     * 用户状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERSTATUS)， 有效/启用 无效/禁用
     */
    private String statusCode;
    /**
     * 买家用户级别类型
     */
    private String buyerLevelCode;
    /**
     * 用户注册渠道平台：Android,ISO,微信,PC端等, 对应S_SYETEM_DICT表的DICTTYPE=CHANNELTYPE的内容
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
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 修改人ID
     */
    private Integer modifyUserId;
    /**
     * 备注信息
     */
    private String note;
    /**
     * VIP会员失效日期
     */
    private Date vipExpireDate;
    /**
     * 会员开通时间
     */
    private Date vipCreateTime;

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

    public String getBuyerLevelCode() {
        return buyerLevelCode;
    }

    public void setBuyerLevelCode(String buyerLevelCode) {
        this.buyerLevelCode = buyerLevelCode;
    }

    public String getRegisterPlatform() {
        return registerPlatform;
    }

    public void setRegisterPlatform(String registerPlatform) {
        this.registerPlatform = registerPlatform;
    }

    public Date getVipExpireDate() {
        return vipExpireDate;
    }

    public void setVipExpireDate(Date vipExpireDate) {
        this.vipExpireDate = vipExpireDate;
    }

    public Date getVipCreateTime() {
        return vipCreateTime;
    }

    public void setVipCreateTime(Date vipCreateTime) {
        this.vipCreateTime = vipCreateTime;
    }

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

}