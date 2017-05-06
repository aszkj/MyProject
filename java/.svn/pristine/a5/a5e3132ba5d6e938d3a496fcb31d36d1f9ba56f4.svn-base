package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 抵用券信息表，映射交易域表YiLiDiOrderCenter.T_VOUCHER
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:42:27
 */
public class Voucher extends BaseModel {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 抵用券包ID
     */
    private Integer vouPackId;
    /**
     * 批次号
     */
    private String batchNo;

    /**
     * 抵用券金额
     */
    private Long vouAmount;

    /**
     * 订单金额限制
     */
    private Long orderAmountLimit;

    /**
     * 产品品类限制，其形式为产品类别编码以逗号连接
     */
    private String productClassLimit;

    /**
     * 业务规则限制，其形式为业务规则限制编码(关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=VOUCHERBUSINESSRULELIMIT))以逗号连接
     */
    private String businessRuleLimit;

    /**
     * 产品限制，其形式为产品ID以逗号连接
     */
    private String productLimit;

    /**
     * 有效期开始时间
     */
    private Date validStartTime;

    /**
     * 有效期结束时间
     */
    private Date validEndTime;

    /**
     * 发放范围编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=VOUCHERGRANTRANGE)
     */
    private String grantRange;

    /**
     * 发放方式编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=VOUCHERGRANTWAY)
     */
    private String grantWay;
    
    /**
     * 使用规格说明
     */
    private String rule;

    /**
     * 客户类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
     */
    private String customerType;

    /**
     * 买家用户类型标示编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=BUYERUSERTYPELABEL)
     */
    private String buyerUserType;

    /**
     * 卖家用户类型标示编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SELLERUSERTYPELABEL)
     */
    private String sellerUserType;

    /**
     * 发放时间
     */
    private Date grantTime;

    /**
     * 发放人
     */
    private Integer grantUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getVouPackId() {
        return vouPackId;
    }

    public void setVouPackId(Integer vouPackId) {
        this.vouPackId = vouPackId;
    }

    public Long getVouAmount() {
        return vouAmount;
    }

    public void setVouAmount(Long vouAmount) {
        this.vouAmount = vouAmount;
    }

    public Long getOrderAmountLimit() {
        return orderAmountLimit;
    }

    public void setOrderAmountLimit(Long orderAmountLimit) {
        this.orderAmountLimit = orderAmountLimit;
    }

    public String getProductClassLimit() {
        return productClassLimit;
    }

    public void setProductClassLimit(String productClassLimit) {
        this.productClassLimit = productClassLimit;
    }

    public String getBusinessRuleLimit() {
        return businessRuleLimit;
    }

    public void setBusinessRuleLimit(String businessRuleLimit) {
        this.businessRuleLimit = businessRuleLimit;
    }

    public String getProductLimit() {
        return productLimit;
    }

    public void setProductLimit(String productLimit) {
        this.productLimit = productLimit;
    }

    public Date getValidStartTime() {
        return validStartTime;
    }

    public void setValidStartTime(Date validStartTime) {
        this.validStartTime = validStartTime;
    }

    public Date getValidEndTime() {
        return validEndTime;
    }

    public void setValidEndTime(Date validEndTime) {
        this.validEndTime = validEndTime;
    }

    public String getGrantRange() {
        return grantRange;
    }

    public void setGrantRange(String grantRange) {
        this.grantRange = grantRange;
    }

    public String getGrantWay() {
        return grantWay;
    }

    public void setGrantWay(String grantWay) {
        this.grantWay = grantWay;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getBuyerUserType() {
        return buyerUserType;
    }

    public void setBuyerUserType(String buyerUserType) {
        this.buyerUserType = buyerUserType;
    }

    public String getSellerUserType() {
        return sellerUserType;
    }

    public void setSellerUserType(String sellerUserType) {
        this.sellerUserType = sellerUserType;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    public Integer getGrantUserId() {
        return grantUserId;
    }

    public void setGrantUserId(Integer grantUserId) {
        this.grantUserId = grantUserId;
    }

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

}
