package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(店铺资金信息实体类，映射数据库表 YiLiDiUserCenter.U_STORE_FINANCE)
 * @author: chenlian
 * @date: 2015-9-18 下午9:19:37
 * 
 */
public class StoreFinance extends BaseModel {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = -8873412257344660258L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
	 */
	private Integer storeId;

	/**
	 * 营业额， 单位 厘
	 */
	private Long turnover;

	/**
	 * 可提现金额， 单位 厘
	 */
	private Long canWithdrawAmount;

	/**
	 * 提现金额， 单位 厘
	 */
	private Long withdrawAmount;

	/**
	 * 补贴金额， 单位 厘
	 */
	private Long subsidyAmount;

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

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Long getTurnover() {
		return turnover;
	}

	public void setTurnover(Long turnover) {
		this.turnover = turnover;
	}

	public Long getCanWithdrawAmount() {
		return canWithdrawAmount;
	}

	public void setCanWithdrawAmount(Long canWithdrawAmount) {
		this.canWithdrawAmount = canWithdrawAmount;
	}

	public Long getWithdrawAmount() {
		return withdrawAmount;
	}

	public void setWithdrawAmount(Long withdrawAmount) {
		this.withdrawAmount = withdrawAmount;
	}

	public Long getSubsidyAmount() {
		return subsidyAmount;
	}

	public void setSubsidyAmount(Long subsidyAmount) {
		this.subsidyAmount = subsidyAmount;
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
