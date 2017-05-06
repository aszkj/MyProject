/**
 * 文件名称：AccountDetailDto.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description:TODO(用户在线交易明细的DTO) 
 * @author:	llp
 * @date:	2015年12月2日 下午6:43:35 
 */
public class OnlinePayDetailDto extends BaseDto {
	private static final long serialVersionUID = 5784064016271159910L;
	/**
	 * 在线交易明细ID，自增主键
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
	 * 在线支付平台
	 */
	private String payPlatformName;
	/**
	 * 在线支付金额
	 */
	private Long payAmount;
	/**
	 * 支付状态
	 */
	private String payStatus;
	/**
	 * 支付状态
	 */
	private String payStatusName;
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

	public String getPayPlatformName() {
		return payPlatformName;
	}

	public void setPayPlatformName(String payPlatformName) {
		this.payPlatformName = payPlatformName;
	}

	public String getPayStatusName() {
		return payStatusName;
	}

	public void setPayStatusName(String payStatusName) {
		this.payStatusName = payStatusName;
	}

}
