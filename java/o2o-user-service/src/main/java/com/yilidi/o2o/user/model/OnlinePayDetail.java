package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * @Description:TODO(用户/门店在线交易明细 实体类，映射数据库表 YiLiDiUserCenter.U_ONLINE_PLAY_LOG )
 * @author: llp
 * @date: 2015年12月2日 下午4:13:38
 * 
 */
public class OnlinePayDetail extends BaseModel {
	private static final long serialVersionUID = -1502064473706644122L;
	/**
	 * 在线交易明细ID，自增主键
	 */
	private Integer id;
	/**
	 * 交易流水号，关联交易域的订单表T_SALE_ORDER的SALEORDERNO字段
	 */
	private String serialNo;
	/**
	 * 用户ID，指明是那个用户消费的，对应u_customer表的ID
	 */
	private Integer userId;
	/**
	 * 在线支付平台（支付宝和微信）
	 */
	private String payPlatform;
	/**
	 * 在线支付账号
	 */
	private String payAccount;
	/**
	 * 在线支付金额
	 */
	private Long payAmount;
	/**
	 * 支付状态：订单支付和订单退款
	 */
	private String payStatus;
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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getPayPlatform() {
		return payPlatform;
	}

	public void setPayPlatform(String payPlatform) {
		this.payPlatform = payPlatform;
	}

	public Long getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(Long payAmount) {
		this.payAmount = payAmount;
	}

	public String getRefundType() {
		return refundType;
	}

	public void setRefundType(String refundType) {
		this.refundType = refundType;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getPayAccount() {
		return payAccount;
	}

	public void setPayAccount(String payAccount) {
		this.payAccount = payAccount;
	}
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUseDesc() {
		return useDesc;
	}

	public void setUseDesc(String useDesc) {
		this.useDesc = useDesc;
	}

}