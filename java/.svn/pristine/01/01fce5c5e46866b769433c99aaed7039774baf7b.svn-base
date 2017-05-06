package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(店铺订单补贴(优惠补贴，物流补贴)金额转可提现记录DTO)
 * @author: llp
 * @date: 2015-11-10 下午9:40:19
 * 
 */
public class StoreSubsidyRecordDto extends BaseDto {

	/**
	 * @Fields serialVersionUID : TODO(serialVersionUID)
	 */
	private static final long serialVersionUID = 4215171406392274895L;

	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
	 */
	private Integer storeId;
	
	/**
	 * 客户名称(门店名称)
	 */
	private String storeName;
	
	/**
	 * 门店编码
	 */
	private String storeCode;

	 /**
     * 订单编号，关联订单域T_SALE_ORDER表的SALEORDERNO
     */
    private String saleOrderNo;
    
    /**
	 * 订单使用的在线支付的补贴金额（现金补贴金额）
	 */
	private Long cashSubsidy;
	/**
	 * 订单中商品差价补贴的总金额
	 */
	private Long priceSubsidy;
	
    /**
	 * 订单使用的优惠券/代金券的补贴金额
	 */
	private Long couponSubsidy;
	
	/**
	 * 订单物流补贴金额，根据系统设置订单满多少给予物流补贴
	 */
	private Long logisticsSubsidy;
	/**
	 * 转可提现状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=TRANSWITHDRAWSTATUS)
	 */
	private String transWithdrawStatus;

	/**
	 * 创建人
	 */
	private Integer createUserId;

	/**
	 * 创建时间（补贴时间）
	 */
	private Date createTime;

	/**
	 * 修改人
	 */
	private Integer modifyUserId;

	/**
	 * 修改时间
	 */
	private Date modifyTime;
	
	/**
	 * 备注信息
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

	public String getTransWithdrawStatus() {
		return transWithdrawStatus;
	}

	public void setTransWithdrawStatus(String transWithdrawStatus) {
		this.transWithdrawStatus = transWithdrawStatus;
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

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}
	
	public Long getCouponSubsidy() {
		return couponSubsidy;
	}

	public void setCouponSubsidy(Long couponSubsidy) {
		this.couponSubsidy = couponSubsidy;
	}

	public Long getLogisticsSubsidy() {
		return logisticsSubsidy;
	}

	public void setLogisticsSubsidy(Long logisticsSubsidy) {
		this.logisticsSubsidy = logisticsSubsidy;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
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

	public Long getCashSubsidy() {
		return cashSubsidy;
	}

	public void setCashSubsidy(Long cashSubsidy) {
		this.cashSubsidy = cashSubsidy;
	}

	public Long getPriceSubsidy() {
		return priceSubsidy;
	}

	public void setPriceSubsidy(Long priceSubsidy) {
		this.priceSubsidy = priceSubsidy;
	}

}
