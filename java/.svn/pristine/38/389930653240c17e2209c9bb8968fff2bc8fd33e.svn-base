package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 订单结算
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午10:59:52
 */
public class SettlementOrderDto extends BaseDto {

    private static final long serialVersionUID = 1L;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 店铺名称
     */
    private String storeName;
    /** 是否是vip预留订单,0-不是,1-是 **/
    private Integer isVipOrder;
    /**
     * 订单金额
     */
    private Long totalAmount;
    /**
     * 优惠金额
     */
    private Long preferentialAmt;
    /**
     * 配送金额
     */
    private Long transferFee;
    /**
     * 应付金额
     */
    private Long payableAmount;

    private List<SaleOrderItemDto> saleOrderItemDtoList;
    /**
     * 优惠券列表
     */
    private List<UserCouponInfoDto> userCouponInfoList;
    /**
     * 抵用券列表
     */
    private List<UserVoucherInfoDto> userVoucherInfoList;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Integer getIsVipOrder() {
        return isVipOrder;
    }

    public void setIsVipOrder(Integer isVipOrder) {
        this.isVipOrder = isVipOrder;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public Long getTransferFee() {
        return transferFee;
    }

    public void setTransferFee(Long transferFee) {
        this.transferFee = transferFee;
    }

    public Long getPayableAmount() {
        return payableAmount;
    }

    public void setPayableAmount(Long payableAmount) {
        this.payableAmount = payableAmount;
    }

    public List<SaleOrderItemDto> getSaleOrderItemDtoList() {
        return saleOrderItemDtoList;
    }

    public void setSaleOrderItemDtoList(List<SaleOrderItemDto> saleOrderItemDtoList) {
        this.saleOrderItemDtoList = saleOrderItemDtoList;
    }

    public List<UserCouponInfoDto> getUserCouponInfoList() {
        return userCouponInfoList;
    }

    public void setUserCouponInfoList(List<UserCouponInfoDto> userCouponInfoList) {
        this.userCouponInfoList = userCouponInfoList;
    }

    public List<UserVoucherInfoDto> getUserVoucherInfoList() {
        return userVoucherInfoList;
    }

    public void setUserVoucherInfoList(List<UserVoucherInfoDto> userVoucherInfoList) {
        this.userVoucherInfoList = userVoucherInfoList;
    }

}
