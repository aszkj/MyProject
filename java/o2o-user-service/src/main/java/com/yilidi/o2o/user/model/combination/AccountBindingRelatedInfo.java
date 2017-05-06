/**
 * 文件名称：AccountBindingRelatedInfo.java
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
 * 功能描述：将门店用户绑定账户银行卡相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountBindingRelatedInfo extends BaseModel {

	private static final long serialVersionUID = 2768830166091073688L;
	
	/**
     * 绑定ID，自增主键
     */
    private Integer bingdingAccountId;
    /**
     * 客户Id
     */
    private Integer customerId;
    /**
	 * 市编码，关联系统域下表S_AREADICT的AREACODE字段
	 */
	private String cityCode;
	/**
	 * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
	 */
	private String countyCode;
	/**
	 * 客户名称(门店名称)
	 */
	private String customerName;
	/**
	 * 门店编码
	 */
	private String storeCode;
    /**
     * 门店详细地址
     */
	private String addressDetail;
	/**
	 * 门店联系人(法人代表名称)
	 */
	private String contactName;
	/**
	 * 联系电话
	 */
	private String telPhone;
	/**
     * 绑定账户类型，关联系统域系统字典表S_SYSTEM_DICT的DICTCODE字段(DICTTYPE=ACCOUNTBINDINGTYPE)
     * 账户类型：开户各银行名称，支付宝，微支付等等
     */
    private String accountBindingType;
    /**
     * 账户转账类型：对公和对私
     */
    private String transferAccountType;
    /**
	 * 开户名
	 */
	private String accountName;
    /**
     * 绑定账户账号(银行卡号，支付宝账号，微信支付账号等)
     */
    private String accountNo;
    /**
     * 绑定银行的支行名称
     */
    private String subBankName;
    /**
     * 持卡人姓名（开户人真实姓名）
     */
    private String masterName;
    /**
     * 持卡人身份证号码
     */
    private String masterIDcardNo;
    /**
     * 持卡人手机号
     */
    private String masterPhoneNo;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    
	public Integer getBingdingAccountId() {
		return bingdingAccountId;
	}
	public void setBingdingAccountId(Integer bingdingAccountId) {
		this.bingdingAccountId = bingdingAccountId;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
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
	public String getAddressDetail() {
		return addressDetail;
	}
	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}
	public String getContactName() {
		return contactName;
	}
	public void setContactName(String contactName) {
		this.contactName = contactName;
	}
	public String getTelPhone() {
		return telPhone;
	}
	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}
	public String getAccountBindingType() {
		return accountBindingType;
	}
	public void setAccountBindingType(String accountBindingType) {
		this.accountBindingType = accountBindingType;
	}
	public String getSubBankName() {
		return subBankName;
	}
	public void setSubBankName(String subBankName) {
		this.subBankName = subBankName;
	}
	public String getMasterName() {
		return masterName;
	}
	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}
	public String getMasterIDcardNo() {
		return masterIDcardNo;
	}
	public void setMasterIDcardNo(String masterIDcardNo) {
		this.masterIDcardNo = masterIDcardNo;
	}
	public String getMasterPhoneNo() {
		return masterPhoneNo;
	}
	public void setMasterPhoneNo(String masterPhoneNo) {
		this.masterPhoneNo = masterPhoneNo;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getStoreCode() {
		return storeCode;
	}
	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}
	public String getAccountNo() {
		return accountNo;
	}
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	public String getTransferAccountType() {
		return transferAccountType;
	}
	public void setTransferAccountType(String transferAccountType) {
		this.transferAccountType = transferAccountType;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
}