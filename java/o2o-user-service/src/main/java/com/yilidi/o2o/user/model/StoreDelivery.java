package com.yilidi.o2o.user.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 店铺接单员实体类，映射数据库表 YiLiDiUserCenter.U_STORE_DELIVERY
 * 
 * @author: heyong
 * @date: 2015年12月10日 上午11:25:19
 * 
 */
public class StoreDelivery extends BaseModel {

	private static final long serialVersionUID = -703012666036947906L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 店铺ID, 关联用户域U_STORE_PROFILE表的ID
	 */
	private Integer storeId;

	/**
	 * 接单员登录账号： （对应user表的username）
	 */
	private String userName;

	/**
	 * 联系人
	 */
	private String contact;

	/**
	 * 手机号码
	 */
	private String mobile;

	/**
	 * 是否有效： （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STOREDELIVERYSTATE的内容）
	 */
	private String state;

	/**
	 * 备注
	 */
	private String remark;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
