/**
 * 文件名称：Account.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：账户实体类，映射数据库表 YiLiDiUserCenter.U_ACCOUNT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class Account extends BaseModel {
	private static final long serialVersionUID = 8614317229757093088L;
	/**
	 * 账户ID，主键
	 */
	private Integer accountId;
	/**
	 * 该帐户所属客户的ID，关联表U_CUSTOMER的customerid字段
	 */
	private Integer customerId;
	/**
	 * 帐户类型：标识该帐户的类型，关联用户域U_ACCOUNT表ACCOUNTTYPECODE字段
	 * 买家：现金账本（欧币）
	 * 卖家：现金账本（订单提现），商品差价补贴账本，优惠补贴账本，物流补贴账本
	 */
	private String accountTypeCode;
	/**
	 * 账本余额，单位 厘
	 */
	private Long currentBalance;
	/**
	 * 冻结金额
	 */
	private Long freezeAmount;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 创建人
	 */
	private Integer createUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;
	/**
	 * 修改人
	 */
	private Integer modifyUserId;

	public Integer getAccountId() {
		return accountId;
	}

	public void setAccountId(Integer accountId) {
		this.accountId = accountId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getAccountTypeCode() {
		return accountTypeCode;
	}

	public void setAccountTypeCode(String accountTypeCode) {
		this.accountTypeCode = accountTypeCode;
	}

	public Long getCurrentBalance() {
		return currentBalance;
	}

	public void setCurrentBalance(Long currentBalance) {
		this.currentBalance = currentBalance;
	}

	public Long getFreezeAmount() {
		return freezeAmount;
	}

	public void setFreezeAmount(Long freezeAmount) {
		this.freezeAmount = freezeAmount;
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

}