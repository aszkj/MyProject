package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：订单支付记录实体类，映射交易域表YiLiDiOrderCenter.T_ORDER_PAYMENT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class OrderPayment extends BaseModel {
    private static final long serialVersionUID = 2310011301577005170L;
    /**
     * 支付ID
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 订单支付方式编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=ORDERPAYMENTPAYTYPE)
     */
    private String payTypeCode;
    /**
     * 账户ID，对应的账户ID
     */
    private Integer accountId;
    /**
     * 支付额， 如果是金钱支付，单位 厘，否则可以是积分或者优惠卷张数*面额
     */
    private Long payAmount;
    /**
     * 支付时间
     */
    private Date createTime;
    /**
     * 支付用户ID
     */
    private Integer createUserId;
    /**
     * 支付交易流水号， 第三方支付平台返回的流水号
     */
    private String seriesNo;
    /**
     * 备注
     */
    private String note;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public Long getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(Long payAmount) {
        this.payAmount = payAmount;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public String getSeriesNo() {
        return seriesNo;
    }

    public void setSeriesNo(String seriesNo) {
        this.seriesNo = seriesNo;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}