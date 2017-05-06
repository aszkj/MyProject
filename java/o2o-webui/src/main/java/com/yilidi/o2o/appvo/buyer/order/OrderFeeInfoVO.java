package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单费用信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class OrderFeeInfoVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;
    /**
     * 订单总金额
     */
    private Long totalAmount;

    /**
     * 订单优惠金额
     */
    private Long preferentialAmt;
    /**
     * 订单配送金额
     */
    private Long transferFee;
    /**
     * 订单应付金额
     */
    private Long payableAmount;

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

}
