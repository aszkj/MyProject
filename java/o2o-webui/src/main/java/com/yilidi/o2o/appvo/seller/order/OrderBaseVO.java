package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.appvo.seller.user.ConsigneeAddressVO;

/**
 * @Description: TODO(订单基础信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:09:37
 */
public class OrderBaseVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 8576744985217410260L;
    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 订单创建时间
     */
    private String createTime;
    /**
     * 订单付款时间
     */
    private String payTime;
    /**
     * 商品金额
     */
    private Long totalAmount;
    /**
     * 应付金额
     */
    private Long payableAmount;
    /**
     * 配送方式
     */
    private Integer deliveryModeCode;
    /**
     * 自提客户联系电话
     */
    private String buyerMobile;
    /**
     * 地址信息
     */
    private ConsigneeAddressVO consigneeAddress;

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPayTime() {
        return payTime;
    }

    public void setPayTime(String payTime) {
        this.payTime = payTime;
    }

    public Long getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Long totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Long getPayableAmount() {
        return payableAmount;
    }

    public void setPayableAmount(Long payableAmount) {
        this.payableAmount = payableAmount;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public String getBuyerMobile() {
        return buyerMobile;
    }

    public void setBuyerMobile(String buyerMobile) {
        this.buyerMobile = buyerMobile;
    }

    public ConsigneeAddressVO getConsigneeAddress() {
        return consigneeAddress;
    }

    public void setConsigneeAddress(ConsigneeAddressVO consigneeAddress) {
        this.consigneeAddress = consigneeAddress;
    }

}
