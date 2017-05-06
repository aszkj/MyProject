package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(申请加盟信息实体类，映射数据库表 YiLiDiUserCenter.U_APPLY_LEAGUE)
 * @author: chenlian
 * @date: 2015-9-18 下午8:21:37
 * 
 */
public class ApplyLeague extends BaseModel {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = 8889856761589265054L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 联系人
	 */
	private String contact;

	/**
	 * 联系人手机号
	 */
	private String mobile;

	/**
	 * 省份编码
	 */
	private String provinceCode;

	/**
	 * 市编码
	 */
	private String cityCode;

	/**
	 * 区县编码
	 */
	private String countyCode;

	/**
	 * 乡镇编码
	 */
	private String townCode;

	/**
	 * 详细地址
	 */
	private String addressDetail;

	/**
	 * 店名
	 */
	private String storeName;

	/**
	 * 创建人
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
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

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
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

}
