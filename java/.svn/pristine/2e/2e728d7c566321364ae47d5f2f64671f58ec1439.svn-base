package com.yilidi.o2o.user.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * @Description:TODO(将用户在线支付明细和用户相关信息进行组合封装，供Mybatis使用) 
 * @author:	llp
 * @date:	2015年12月2日 下午4:55:59 
 */
public class OnlinePayDetailRelatedInfo extends BaseModel {
	private static final long serialVersionUID = -6866176975787889746L;
	/**
	 * 账户明细ID，自增主键
	 */
	private Integer id;
	/**
	 * 交易流水号，关联交易域的订单表T_SALE_ORDER的SALEORDERNO字段
	 */
	private String serialNo;
	/**
	 * 用户ID，指明是那个用户消费的
	 */
	private Integer userId;
	/**
	 * 客户类别
	 */
	private String customerType;
	/**
	 * 门店编码
	 */
	private String storeCode;
	/**
	 * 门店名称
	 */
	private String storeName;
	/**
	 * 用户登录账号，用户名
	 */
	private String userName;
	/**
	 * 在线支付平台（支付宝和微信）
	 */
	private String payPlatform;
	/**
	 * 在线支付金额
	 */
	private Long payAmount;
	/**
	 * 支付状态
	 */
	private String payStatus;
	/**
	 * 退款操作类型：卖家：运营取消订单退款。买家：用户取消和运营取消
	 */
	private String refundType;
	/**
	 * 消费时间
	 */
	private Date createTime;
	/**
	 * 消费描述
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

	public String getUseDesc() {
		return useDesc;
	}

	public void setUseDesc(String useDesc) {
		this.useDesc = useDesc;
	}
	
	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
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

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
}