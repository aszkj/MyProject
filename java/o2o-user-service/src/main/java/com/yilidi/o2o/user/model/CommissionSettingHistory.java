package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：佣金结算设置历史记录实体类，映射用户域表YiLiDiUserCenter.U_COMMISSION_SETTING_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CommissionSettingHistory extends BaseModel {

	private static final long serialVersionUID = 4432538215291233263L;

	/**
	 * ID, 自增主键
	 */
	private Integer id;
	/**
	 * 设置ID,关联U_COMMISSION_SETTING的settingid字段
	 */
	private Integer settingId;
	/**
	 * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
	 */
	private Integer storeId;
	/**
	 * 结算方式，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONCLEARTYPE)
	 */
	private String clearType;
	/**
	 * 费率
	 */
	private Integer rate;
	/**
	 * 生效日期
	 */
	private Date effectiveDate;
	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyDate;
	/**
	 * 表示该设置是否已同步到表U_COMMISSION_SETTING中，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONSYNCFLAG)
	 */
	private String synFlag;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSettingId() {
		return settingId;
	}

	public void setSettingId(Integer settingId) {
		this.settingId = settingId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public String getClearType() {
		return clearType;
	}

	public void setClearType(String clearType) {
		this.clearType = clearType;
	}

	public Integer getRate() {
		return rate;
	}

	public void setRate(Integer rate) {
		this.rate = rate;
	}

	public Date getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(Date effectiveDate) {
		this.effectiveDate = effectiveDate;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getSynFlag() {
		return synFlag;
	}

	public void setSynFlag(String synFlag) {
		this.synFlag = synFlag;
	}
}