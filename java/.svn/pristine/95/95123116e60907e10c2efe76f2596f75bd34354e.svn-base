package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：客户收货地址实体类，映射用户域表YiLiDiUserCenter.U_CONSIGNEE_ADDRESS <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ConsigneeAddress extends BaseModel {
	private static final long serialVersionUID = -49964488650630717L;
	/**
	 * 地址id，自增主键
	 */
	private Integer addressId;
	/**
	 * 客户ID，关联用户域表U_CUSTOMER字段CUSTOMERID，标识该地址属于那个客户
	 */
	private Integer customerId;
	/**
	 * 省份编码， 关联系统域表S_AREADICT的AREACODE字段
	 */
	private String provinceCode;
	/**
	 * 市编码， 关联系统域表S_AREADICT的AREACODE字段
	 */
	private String cityCode;
	/**
	 * 区/县编码， 关联系统域表S_AREADICT的AREACODE字段
	 */
	private String countyCode;
	/**
	 * 乡/镇编码， 关联系统域表S_AREADICT的AREACODE字段
	 */
	private String townCode;
	/**
	 * 具体地址信息
	 */
	private String addressDetail;
	/**
	 * 默认标志, "CONSADDRDEFAULTFLAG_NO" 不是默认的收货地址， “CONSADDRDEFAULTFLAG_YES” 默认收货地址
	 */
	private String defaultFlag;
	/**
	 * 收货人姓名
	 */
	private String consigneeName;
	/**
	 * 收货人手机号码
	 */
	private String phoneNo;
	
	/**
	 * 小区ID, 关联用户域U_COMMUNITY表的ID
	 */
	private Integer communityId;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 修改用户id
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 状态, "CONSADDRSTATUS_OFF"禁用 ，"CONSADDRSTATUS_ON" 启用
	 */
	private String status;
	/**
	 * 备注信息
	 */
	private String note;

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
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

	public String getDefaultFlag() {
		return defaultFlag;
	}

	public void setDefaultFlag(String defaultFlag) {
		this.defaultFlag = defaultFlag;
	}

	public String getConsigneeName() {
		return consigneeName;
	}

	public void setConsigneeName(String consigneeName) {
		this.consigneeName = consigneeName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	
	public Integer getCommunityId() {
		return communityId;
	}

	public void setCommunityId(Integer communityId) {
		this.communityId = communityId;
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

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
}