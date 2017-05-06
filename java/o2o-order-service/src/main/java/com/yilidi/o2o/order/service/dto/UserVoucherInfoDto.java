package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 用户抵用券信息DTO
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午3:21:56
 */
public class UserVoucherInfoDto extends BaseDto {

    private static final long serialVersionUID = -1947534457408931324L;

    /**
     * 用户抵用券ID
     */
    private Integer userVoucherId;

    /**
     * 抵用券ID
     */
    private Integer vouId;

    /**
     * 抵用券/券包名称
     */
    private String vouName;

    /**
     * 用户名称
     */
    private String userName;

    /**
     * 用户手机号
     */
    private String phone;

    /**
     * 抵用券使用状态
     */
    private String status;

    /**
     * 抵用券使用状态名称
     */
    private String statusName;

    /**
     * 抵用券金额 单位 厘
     */
    private Long vouAmount;

    /**
     * 订单金额限制，单位 厘
     */
    private Long orderAmountLimit;

    /**
     * 产品品类限制
     */
    private String productClassLimit;

    /**
     * 业务规则限制
     */
    private String businessRuleLimit;

    /**
     * 产品限制
     */
    private String productLimit;

    /**
     * 限制范围名称
     */
    private String limitRangeName;

    /**
     * 限制范围详情
     */
    private String limitRangeDetails;

    /**
     * 有效期开始时间
     */
    private Date validStartTime;

    /**
     * 有效期结束时间
     */
    private Date validEndTime;

    /**
     * 发放时间
     */
    private Date grantTime;

    /**
     * 使用时间
     */
    private Date useTime;

    /**
     * 使用规则
     */
    private String rule;
    /**
     * 订单能否使用该奖券：（前端需要根据该字段进行重新排序） 0：不能使用 1：能使用
     */
    private Integer wouldUse;
    /**
     * 抵用券可用的商品列表
     */
    private List<Integer> saleProductIds;

    public Integer getUserVoucherId() {
        return userVoucherId;
    }

    public void setUserVoucherId(Integer userVoucherId) {
        this.userVoucherId = userVoucherId;
    }

    public Integer getVouId() {
        return vouId;
    }

    public void setVouId(Integer vouId) {
        this.vouId = vouId;
    }

    public String getVouName() {
        return vouName;
    }

    public void setVouName(String vouName) {
        this.vouName = vouName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
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

    public String getLimitRangeName() {
        return limitRangeName;
    }

    public void setLimitRangeName(String limitRangeName) {
        this.limitRangeName = limitRangeName;
    }

    public String getLimitRangeDetails() {
        return limitRangeDetails;
    }

    public void setLimitRangeDetails(String limitRangeDetails) {
        this.limitRangeDetails = limitRangeDetails;
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

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    public Date getUseTime() {
        return useTime;
    }

    public void setUseTime(Date useTime) {
        this.useTime = useTime;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    public Integer getWouldUse() {
        return wouldUse;
    }

    public void setWouldUse(Integer wouldUse) {
        this.wouldUse = wouldUse;
    }

    public List<Integer> getSaleProductIds() {
        return saleProductIds;
    }

    public void setSaleProductIds(List<Integer> saleProductIds) {
        this.saleProductIds = saleProductIds;
    }

}
