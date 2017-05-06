package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;

/**
 * 订单支付成功
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class PaySuccessInfoVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 订单编号
     */
    private String saleOrderNo;

    /**
     * 订单已付金额
     */
    private Long paidAmount;
    /**
     * 优惠金额
     */
    private Long preferentialAmt;
    /**
     * 配送方式编码
     */
    private Integer deliveryModeCode;
    /**
     * 配送方式名称
     */
    private String deliveryModeName;
    /**
     * 送货时间说明
     */
    private String deliveryTimeNote;
    /**
     * 提货码
     */
    private String receiveCode;
    /**
     * 支付方式名称
     */
    private String payTypeName;
    /**
     * 店铺信息
     */
    private StoreInfoVO storeInfo;

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Long getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(Long paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public String getDeliveryModeName() {
        return deliveryModeName;
    }

    public void setDeliveryModeName(String deliveryModeName) {
        this.deliveryModeName = deliveryModeName;
    }

    public String getDeliveryTimeNote() {
        return deliveryTimeNote;
    }

    public void setDeliveryTimeNote(String deliveryTimeNote) {
        this.deliveryTimeNote = deliveryTimeNote;
    }

    public String getReceiveCode() {
        return receiveCode;
    }

    public void setReceiveCode(String receiveCode) {
        this.receiveCode = receiveCode;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
    }

    public StoreInfoVO getStoreInfo() {
        return storeInfo;
    }

    public void setStoreInfo(StoreInfoVO storeInfo) {
        this.storeInfo = storeInfo;
    }

}
