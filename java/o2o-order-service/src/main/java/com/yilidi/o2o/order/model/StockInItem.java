package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品入库记录实体类，映射产品域表YiLiDiOrderCenter.T_STOCKIN_ITEM<br/>
 * 作 者：simpson <br/>
 * 
 * Bug的ID：<br/>
 * 修改内容：<br/>
 */
public class StockInItem extends BaseModel {
    private static final long serialVersionUID = 5464061361932777480L;
    /**
     * 入库记录明细ID，主键自增
     */
    private Integer id;
    /**
     * 入库记录ID
     */
    private Integer stockInId;
    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 入库数量
     */
    private Integer quantity;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStockInId() {
        return stockInId;
    }

    public void setStockInId(Integer stockInId) {
        this.stockInId = stockInId;
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

}