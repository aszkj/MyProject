package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：出库明细记录实体类，映射交易域表YiLiDiOrderCenter.T_STOCKOUT_ITEM <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StockOutItem extends BaseModel {
    private static final long serialVersionUID = 4576615375855128336L;
    /**
     * 出库明细编号，主键自增
     */
    private Integer id;
    /**
     * 出库单ID，关联交易域出库单表T_STOCKOUT的STOCKOUTID字段
     */
    private Integer stockOutId;
    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 出库数量，对应该款产品的出库数量
     */
    private Integer quantity;
    /**
     * 发货记录明细ID
     */
    private Integer sendOrderItemId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStockOutId() {
        return stockOutId;
    }

    public void setStockOutId(Integer stockOutId) {
        this.stockOutId = stockOutId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getSendOrderItemId() {
        return sendOrderItemId;
    }

    public void setSendOrderItemId(Integer sendOrderItemId) {
        this.sendOrderItemId = sendOrderItemId;
    }

}