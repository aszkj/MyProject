package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：首单记录信息表，映射交易域表YiLiDiOrderCenter.T_FIRST_ORDER_CUSTOMER_REC <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class FirstOrderCustomerRec extends BaseModel {

    private static final long serialVersionUID = -7949171434554901124L;

    /**
     * 记录编号，主键
     */
    private Integer id;
    /**
     * 买家客户ID
     */
    private Integer buyerCustomerId;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 首单类型编码,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=FIRSTORDERTYPE)
     */
    private String firstOrderType;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getFirstOrderType() {
        return firstOrderType;
    }

    public void setFirstOrderType(String firstOrderType) {
        this.firstOrderType = firstOrderType;
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

}