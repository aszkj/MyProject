package com.yldbkd.www.seller.android.bean;

/**
 * 调货单基础信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class AllotOrderBase extends BaseModel {

    /**
     * 调货单ID
     */
    private Integer allotOrderId;
    /**
     * 调货单编号
     */
    private String allotOrderNo;
    /**
     * 调货单状态
     */
    private Integer statusCode;
    /**
     * 调货单状态名称
     */
    private String statusCodeName;
    /**
     * 调拨商品数量
     */
    private Integer allotTotalCount;
    /**
     * 调拨商品金额
     */
    private Long allotTotalAmount;
    /**
     * 调拨实际商品数量
     */
    private Integer realAllotTotalCount;
    /**
     * 调拨实际商品金额
     */
    private Long realAllotTotalAmount;
    /**
     * 调出仓库名称
     */
    private String allotFromStoreName;
    /**
     * 调货单创建时间
     */
    private String createTime;
    /**
     * 收货人
     */
    private String consignee;
    /**
     * 收货人电话
     */
    private String consMobile;
    /**
     * 收货地址
     */
    private String consAddress;
    /**
     * 调货单验货时间
     */
    private String statusTime;

    public Integer getAllotOrderId() {
        return allotOrderId;
    }

    public void setAllotOrderId(Integer allotOrderId) {
        this.allotOrderId = allotOrderId;
    }

    public String getAllotOrderNo() {
        return allotOrderNo;
    }

    public void setAllotOrderNo(String allotOrderNo) {
        this.allotOrderNo = allotOrderNo;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public Integer getAllotTotalCount() {
        return allotTotalCount;
    }

    public void setAllotTotalCount(Integer allotTotalCount) {
        this.allotTotalCount = allotTotalCount;
    }

    public Long getAllotTotalAmount() {
        return allotTotalAmount;
    }

    public void setAllotTotalAmount(Long allotTotalAmount) {
        this.allotTotalAmount = allotTotalAmount;
    }

    public Integer getRealAllotTotalCount() {
        return realAllotTotalCount;
    }

    public void setRealAllotTotalCount(Integer realAllotTotalCount) {
        this.realAllotTotalCount = realAllotTotalCount;
    }

    public Long getRealAllotTotalAmount() {
        return realAllotTotalAmount;
    }

    public void setRealAllotTotalAmount(Long realAllotTotalAmount) {
        this.realAllotTotalAmount = realAllotTotalAmount;
    }

    public String getAllotFromStoreName() {
        return allotFromStoreName;
    }

    public void setAllotFromStoreName(String allotFromStoreName) {
        this.allotFromStoreName = allotFromStoreName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getConsMobile() {
        return consMobile;
    }

    public void setConsMobile(String consMobile) {
        this.consMobile = consMobile;
    }

    public String getConsAddress() {
        return consAddress;
    }

    public void setConsAddress(String consAddress) {
        this.consAddress = consAddress;
    }

    public String getStatusTime() {
        return statusTime;
    }

    public void setStatusTime(String statusTime) {
        this.statusTime = statusTime;
    }
}
