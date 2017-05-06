/**
 * 文件名称：UserQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：用户查询条件封装类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class UserQuery extends BaseQuery {

    private static final long serialVersionUID = 3063107551753400367L;
    /**
     * Customer表ID
     */
    private Integer customerId;
    /**
     * 用户User表ID
     */
    private Integer userId;
    /**
     * 用户类型：买家,卖家，运营商
     */
    private String customerType;
    /**
     * 主账号标志
     */
    private String masterFlag;
    /**
     * 审核状态
     */
    private String auditCode;
    /**
     * 用户状态：有效，失效
     */
    private String statusCode;
    /**
     * 表
     */
    private String table;
    /**
     * 用户名称
     */
    private String userName;
    /**
     * 用户手机号码
     */
    private String telPhone;
    /**
     * 用户邮箱
     */
    private String email;
    /**
     * 注册时间
     */
    private String createTime;
    /**
     * 用户类型
     */
    private String buyerLevelCode;
    /**
     * 真实姓名
     */
    private String realName;
    /**
     * 所在部门
     */
    private String department;

    /**
     * 创建开始时间
     */
    private String startCreateTime;
    /**
     * 创建结束时间
     */
    private String endCreateTime;
    /**
     * 创建开始时间
     */
    private Date startCreateDate;
    /**
     * 创建结束时间
     */
    private Date endCreateDate;

    /**
     * 会员开通开始时间
     */
    private String startVipCreateTime;
    /**
     * 会员开通结束时间
     */
    private String endVipCreateTime;
    /**
     * 会员开通开始时间
     */
    private Date startVipCreateDate;
    /**
     * 会员开通结束时间
     */
    private Date endVipCreateDate;

    /**
     * 会员到期开始时间
     */
    private String startVipExpireTime;
    /**
     * 会员到期结束时间
     */
    private String endVipExpireTime;
    /**
     * 会员到期开始时间
     */
    private Date startVipExpireDate;
    /**
     * 会员到期结束时间
     */
    private Date endVipExpireDate;

    /**
     * 用户角色
     */
    private String userRole;
    /**
     * 店铺id
     */
    private Integer storeId;
    
    /**
     * 店鋪編號 
     */
    private String storeCode;
    /**
     * 店鋪名稱 
     */
    private String storeName;

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
    }

    public String getAuditCode() {
        return auditCode;
    }

    public void setAuditCode(String auditCode) {
        this.auditCode = auditCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getBuyerLevelCode() {
        return buyerLevelCode;
    }

    public void setBuyerLevelCode(String buyerLevelCode) {
        this.buyerLevelCode = buyerLevelCode;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(String telPhone) {
        this.telPhone = telPhone;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStartCreateTime() {
        return startCreateTime;
    }

    public void setStartCreateTime(String startCreateTime) {
        this.startCreateTime = startCreateTime;
    }

    public String getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(String endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public Date getStartCreateDate() {
        return startCreateDate;
    }

    public void setStartCreateDate(Date startCreateDate) {
        this.startCreateDate = startCreateDate;
    }

    public Date getEndCreateDate() {
        return endCreateDate;
    }

    public void setEndCreateDate(Date endCreateDate) {
        this.endCreateDate = endCreateDate;
    }

    public String getStartVipCreateTime() {
        return startVipCreateTime;
    }

    public void setStartVipCreateTime(String startVipCreateTime) {
        this.startVipCreateTime = startVipCreateTime;
    }

    public String getEndVipCreateTime() {
        return endVipCreateTime;
    }

    public void setEndVipCreateTime(String endVipCreateTime) {
        this.endVipCreateTime = endVipCreateTime;
    }

    public Date getStartVipCreateDate() {
        return startVipCreateDate;
    }

    public void setStartVipCreateDate(Date startVipCreateDate) {
        this.startVipCreateDate = startVipCreateDate;
    }

    public Date getEndVipCreateDate() {
        return endVipCreateDate;
    }

    public void setEndVipCreateDate(Date endVipCreateDate) {
        this.endVipCreateDate = endVipCreateDate;
    }

    public String getStartVipExpireTime() {
        return startVipExpireTime;
    }

    public void setStartVipExpireTime(String startVipExpireTime) {
        this.startVipExpireTime = startVipExpireTime;
    }

    public String getEndVipExpireTime() {
        return endVipExpireTime;
    }

    public void setEndVipExpireTime(String endVipExpireTime) {
        this.endVipExpireTime = endVipExpireTime;
    }

    public Date getStartVipExpireDate() {
        return startVipExpireDate;
    }

    public void setStartVipExpireDate(Date startVipExpireDate) {
        this.startVipExpireDate = startVipExpireDate;
    }

    public Date getEndVipExpireDate() {
        return endVipExpireDate;
    }

    public void setEndVipExpireDate(Date endVipExpireDate) {
        this.endVipExpireDate = endVipExpireDate;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

}
