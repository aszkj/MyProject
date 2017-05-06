package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：佣金结算设置实体类，映射用户域表YiLiDiUserCenter.U_COMMISSION_SETTING <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CommissionSetting extends BaseModel {
	private static final long serialVersionUID = -7973951039495431063L;
	/**
	 * 设置ID，自增主键
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
	 * 生效时间
	 */
	private Date effectiveDate;
	/**
	 * 状态。当该供应商被禁用后 该状态为无效。关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONSTATUS)
	 */
	private String status;

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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}