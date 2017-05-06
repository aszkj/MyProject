package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class OrderBaseInfoVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 订单ID
     */
    private Integer saleOrderId;
    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 下单时间
     */
    private String createTime;
    /**
     * 订单状态
     */
    private Integer statusCode;
    /**
     * 状态名称
     */
    private String statusCodeName;
    /**
     * 支付方式code
     */
    private String payTypeCode;
    /**
     * 支付方式名称
     */
    private String payTypeName;
    /**
     * 配送方式
     */
    private Integer deliveryModeCode;
    /**
     * 配送方式名称
     */
    private String deliveryModeName;
    /**
     * 订单备注
     */
    private String note;
    /**
     * 订单是否已评价，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=APPRAISEFLAG)
     */
    private Integer isEvaluated;

    public Integer getIsEvaluated() {
        return isEvaluated;
    }

    public void setIsEvaluated(Integer isEvaluated) {
        this.isEvaluated = isEvaluated;
    }

    public Integer getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(Integer saleOrderId) {
        this.saleOrderId = saleOrderId;
    }

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

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public String getPayTypeName() {
        return payTypeName;
    }

    public void setPayTypeName(String payTypeName) {
        this.payTypeName = payTypeName;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

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

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

}
