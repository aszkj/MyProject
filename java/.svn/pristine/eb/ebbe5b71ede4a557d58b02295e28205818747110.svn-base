/**
 * 文件名称：CustomerRelatedInfo.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：将客户相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CustomerRelatedInfo extends BaseModel {

    private static final long serialVersionUID = 2768830166091073688L;

    /**
     * 客户ID，自增主键
     */
    private Integer id;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 用户属性ID
     */
    private Integer userProfileId;

    /**
     * 主用户ID, 关联用户域U_USER表的USERID字段，标识该用户为主帐号用户
     */
    private Integer masterUserId;

    /**
     * 客户名称：零售商名称，供应商名称，运营商（机构）名称
     */
    private String customerName;

    /**
     * 客户类型：关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
     */
    private String customerType;

    /**
     * 支付密码
     */
    private String payPassword;

    /**
     * 法人代表名称
     */
    private String masterName;

    /**
     * 身份证号码
     */
    private String idCardNo;

    /**
     * 身份证扫描件URL地址
     */
    private String idCardUrl;

    /**
     * 联系电话
     */
    private String telPhone;

    /**
     * 省份编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String provinceCode;

    /**
     * 市编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String cityCode;

    /**
     * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String countyCode;

    /**
     * 乡镇编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String townCode;

    /**
     * 详细地址
     */
    private String addressDetail;

    /**
     * 每个客户最多允许创建的子用户数
     */
    private Integer maxUserCount;

    /**
     * 零售商用户级别， 关联系统域系统字典S_SYSTEM_DICT表的DICTCODE字段(DICTTYPE=BUYERLEVEL)
     */
    private String buyerLevelCode;

    /**
     * 供应商用户级别编码， 关联系统域系统字典S_SYSTEM_DICT表的DICTCODE字段(DICTTYPE=SELLERLEVEL)
     */
    private String sellerLevelCode;

    /**
     * 营业执照编码
     */
    private String businessLicenseNo;

    /**
     * 营业执照扫描件URL
     */
    private String licenseUrl;

    /**
     * 营业执照签发机构
     */
    private String authOrganization;

    /**
     * 营业执照有效期
     */
    private Date expireDate;

    /**
     * 税务登记编码
     */
    private String taxCode;

    /**
     * 税务扫描件URL
     */
    private String taxUrl;

    /**
     * 客户状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERSTATUS)， 有效/启用 无效/禁用
     */
    private String customerStatusCode;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建者
     */
    private Integer createUserId;

    /**
     * 修改时间
     */
    private Date modifyTime;

    /**
     * 修改者
     */
    private Integer modifyUserId;

    /**
     * 备注信息
     */
    private String note;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 电话号码
     */
    private String phone;

    /**
     * 主帐号标识："1"主帐号 "0" 子帐号，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERMASTERFLAG)
     */
    private String masterFlag;

    /**
     * 用户状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERSTATUS)， 有效/启用 无效/禁用
     */
    private String userStatusCode;

    /**
     * 审核状态编码，关联系统域系统字典S_SYSTEM_DICT的DICTCODE字段(DICTTYPE=USERAUDITSTATUS)
     */
    private String auditStatusCode;

    /**
     * 审核时间
     */
    private Date auditTime;

    /**
     * 审核人ID
     */
    private Integer auditUserId;

    /**
     * 审核人用户名
     */
    private String auditUserName;

    /**
     * 审核意见
     */
    private String auditNote;

    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 电子邮箱
     */
    private String email;

    /**
     * 用户省份编码
     */
    private String userProvinceCode;

    /**
     * 用户市编码
     */
    private String userCityCode;

    /**
     * 用户区县编码
     */
    private String userCountyCode;

    /**
     * 用户乡镇编码
     */
    private String userTownCode;
    /**
     * VIP会员失效日期
     */
    private Date vipExpireDate;
    /**
     * 会员开通时间
     */
    private Date vipCreateTime;

    /**
     * 邀请客户ID
     */
    private Integer inviteCustomerId;
    /**
     * 邀请码
     */
    private String invitationCode;
    /**
     * 推广客户ID
     */
    private Integer recommendCustomerId;

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

    public Integer getUserProfileId() {
        return userProfileId;
    }

    public void setUserProfileId(Integer userProfileId) {
        this.userProfileId = userProfileId;
    }

    public Integer getMasterUserId() {
        return masterUserId;
    }

    public void setMasterUserId(Integer masterUserId) {
        this.masterUserId = masterUserId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getPayPassword() {
        return payPassword;
    }

    public void setPayPassword(String payPassword) {
        this.payPassword = payPassword;
    }

    public String getMasterName() {
        return masterName;
    }

    public void setMasterName(String masterName) {
        this.masterName = masterName;
    }

    public String getIdCardNo() {
        return idCardNo;
    }

    public void setIdCardNo(String idCardNo) {
        this.idCardNo = idCardNo;
    }

    public String getIdCardUrl() {
        return idCardUrl;
    }

    public void setIdCardUrl(String idCardUrl) {
        this.idCardUrl = idCardUrl;
    }

    public String getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(String telPhone) {
        this.telPhone = telPhone;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getTownCode() {
        return townCode;
    }

    public void setTownCode(String townCode) {
        this.townCode = townCode;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public Integer getMaxUserCount() {
        return maxUserCount;
    }

    public void setMaxUserCount(Integer maxUserCount) {
        this.maxUserCount = maxUserCount;
    }

    public String getBuyerLevelCode() {
        return buyerLevelCode;
    }

    public void setBuyerLevelCode(String buyerLevelCode) {
        this.buyerLevelCode = buyerLevelCode;
    }

    public String getSellerLevelCode() {
        return sellerLevelCode;
    }

    public void setSellerLevelCode(String sellerLevelCode) {
        this.sellerLevelCode = sellerLevelCode;
    }

    public String getBusinessLicenseNo() {
        return businessLicenseNo;
    }

    public void setBusinessLicenseNo(String businessLicenseNo) {
        this.businessLicenseNo = businessLicenseNo;
    }

    public String getLicenseUrl() {
        return licenseUrl;
    }

    public void setLicenseUrl(String licenseUrl) {
        this.licenseUrl = licenseUrl;
    }

    public String getAuthOrganization() {
        return authOrganization;
    }

    public void setAuthOrganization(String authOrganization) {
        this.authOrganization = authOrganization;
    }

    public Date getExpireDate() {
        return expireDate;
    }

    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    public String getTaxCode() {
        return taxCode;
    }

    public void setTaxCode(String taxCode) {
        this.taxCode = taxCode;
    }

    public String getTaxUrl() {
        return taxUrl;
    }

    public void setTaxUrl(String taxUrl) {
        this.taxUrl = taxUrl;
    }

    public String getCustomerStatusCode() {
        return customerStatusCode;
    }

    public void setCustomerStatusCode(String customerStatusCode) {
        this.customerStatusCode = customerStatusCode;
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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMasterFlag() {
        return masterFlag;
    }

    public void setMasterFlag(String masterFlag) {
        this.masterFlag = masterFlag;
    }

    public String getUserStatusCode() {
        return userStatusCode;
    }

    public void setUserStatusCode(String userStatusCode) {
        this.userStatusCode = userStatusCode;
    }

    public String getAuditStatusCode() {
        return auditStatusCode;
    }

    public void setAuditStatusCode(String auditStatusCode) {
        this.auditStatusCode = auditStatusCode;
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

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserProvinceCode() {
        return userProvinceCode;
    }

    public void setUserProvinceCode(String userProvinceCode) {
        this.userProvinceCode = userProvinceCode;
    }

    public String getUserCityCode() {
        return userCityCode;
    }

    public void setUserCityCode(String userCityCode) {
        this.userCityCode = userCityCode;
    }

    public String getUserCountyCode() {
        return userCountyCode;
    }

    public void setUserCountyCode(String userCountyCode) {
        this.userCountyCode = userCountyCode;
    }

    public String getUserTownCode() {
        return userTownCode;
    }

    public void setUserTownCode(String userTownCode) {
        this.userTownCode = userTownCode;
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

    public Integer getInviteCustomerId() {
        return inviteCustomerId;
    }

    public void setInviteCustomerId(Integer inviteCustomerId) {
        this.inviteCustomerId = inviteCustomerId;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

    public Integer getRecommendCustomerId() {
        return recommendCustomerId;
    }

    public void setRecommendCustomerId(Integer recommendCustomerId) {
        this.recommendCustomerId = recommendCustomerId;
    }

}