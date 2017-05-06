/**
 * 文件名称：AccountDetail.java
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
 * 功能描述：账户明细 实体类，映射数据库表 YiLiDiUserCenter.U_ACCOUNT_DETAIL <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AccountDetail extends BaseModel {
	private static final long serialVersionUID = -7039662373095310176L;
	/**
	 * 账户明细ID，自增主键
	 */
	private Integer accountDetailId;
	/**
	 * 交易流水号，关联交易域的订单表T_SALE_ORDER的SALEORDERNO字段
	 */
	private String serialNo;
	/**
	 * 用户ID，指明是那个用户消费的,对应U_CUSTOMER表的ID
	 */
	private Integer userId;
	/**
	 * 明细类别：ACCOUNTDETAILTYPE_IN: 收入, ACCOUNTDETAILTYPE_OUT: 支出
	 */
	private String detailType;
	/**
	 * 帐户金额变化类型：ACCOUNTCHANGETYPE_CHARGE: 充值、ACCOUNTCHANGETYPE_WITHDRAW: 提款、ACCOUNTCHANGETYPE_PAY:
	 * 付款、ACCOUNTCHANGETYPE_REFUND: 退款.... 在系统字典中定义
	 */
	private String changeType;
	/**
	 * 账本总支付金额
	 */
	private Long totalAccountAmount;
	/**
	 * 现金账本支付金额
	 */
	private Long cashAccountAmount;
	/**
	 * 优惠补贴账本支付金额
	 */
	private Long couponAccountAmount;
	/**
	 * 物流补贴账本支付金额
	 */
	private Long logisticsAccountAmount;
	/**
	 * 商品补贴账本支付金额
	 */
	private Long productAccountAmount;
	/**
	 * 交易/消费时间
	 */
	private Date createTime;
	/**
	 * 退款操作类型：卖家：运营取消订单退款。买家：用户取消和运营取消
	 */
	private String refundType;
	/**
	 * 消费描述：订单：订单支付的描述，或是系统充值，订单支付，订单退款等
	 */
	private String useDesc;
	
	public Integer getAccountDetailId() {
		return accountDetailId;
	}

	public void setAccountDetailId(Integer accountDetailId) {
		this.accountDetailId = accountDetailId;
	}

	public String getSerialNo() {
		return serialNo;
	}

	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getDetailType() {
		return detailType;
	}

	public void setDetailType(String detailType) {
		this.detailType = detailType;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getUseDesc() {
		return useDesc;
	}

	public void setUseDesc(String useDesc) {
		this.useDesc = useDesc;
	}

	public String getChangeType() {
		return changeType;
	}

	public void setChangeType(String changeType) {
		this.changeType = changeType;
	}

	public String getRefundType() {
		return refundType;
	}

	public void setRefundType(String refundType) {
		this.refundType = refundType;
	}

	public Long getTotalAccountAmount() {
		return totalAccountAmount;
	}

	public void setTotalAccountAmount(Long totalAccountAmount) {
		this.totalAccountAmount = totalAccountAmount;
	}

	public Long getCashAccountAmount() {
		return cashAccountAmount;
	}

	public void setCashAccountAmount(Long cashAccountAmount) {
		this.cashAccountAmount = cashAccountAmount;
	}

	public Long getCouponAccountAmount() {
		return couponAccountAmount;
	}

	public void setCouponAccountAmount(Long couponAccountAmount) {
		this.couponAccountAmount = couponAccountAmount;
	}

	public Long getLogisticsAccountAmount() {
		return logisticsAccountAmount;
	}

	public void setLogisticsAccountAmount(Long logisticsAccountAmount) {
		this.logisticsAccountAmount = logisticsAccountAmount;
	}

	public Long getProductAccountAmount() {
		return productAccountAmount;
	}

	public void setProductAccountAmount(Long productAccountAmount) {
		this.productAccountAmount = productAccountAmount;
	}
}