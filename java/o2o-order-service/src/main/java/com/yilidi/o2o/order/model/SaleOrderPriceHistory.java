package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：订单商品价格修改历史记录数据模型， 映射交易域表YiLiDiOrderCenter.T_SALE_ORDER_PRICE_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderPriceHistory extends BaseModel {

    private static final long serialVersionUID = 6171241805376426239L;

    /**
     * ID, 主键
     */
    private Integer id;
    /**
     * 订单编号，关联产品域供应商产品表T_SALE_ORDER的SALEORDERNO字段
     */
    private String saleOrderNo;
    /**
     * 修改类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=ORDERPRICEHISCHANGETYPE)
     */
    private String changeType;
    /**
     * 订单明细ID，关联产品域供应商产品表T_SALE_ORDER_ITEM的ID字段
     */
    private Integer saleOrderItemId;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 商品id
     */
    private Integer saleProductId;
    /**
     * 折扣数
     */
    private Integer discount;
    /**
     * 修改前费用, 单位厘
     */
    private Long preFee;
    /**
     * 修改后费用，单位厘
     */
    private Long changedFee;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 修改用户id
     */
    private Integer midifyUserId;
    /**
     * 有效状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=ORDERPRICEHISSTATUS)
     */
    private String statusCode;
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

    public String getChangeType() {
        return changeType;
    }

    public void setChangeType(String changeType) {
        this.changeType = changeType;
    }

    public Integer getSaleOrderItemId() {
        return saleOrderItemId;
    }

    public void setSaleOrderItemId(Integer saleOrderItemId) {
        this.saleOrderItemId = saleOrderItemId;
    }

    public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public Long getPreFee() {
        return preFee;
    }

    public void setPreFee(Long preFee) {
        this.preFee = preFee;
    }

    public Long getChangedFee() {
        return changedFee;
    }

    public void setChangedFee(Long changedFee) {
        this.changedFee = changedFee;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getMidifyUserId() {
        return midifyUserId;
    }

    public void setMidifyUserId(Integer midifyUserId) {
        this.midifyUserId = midifyUserId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}