package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 出库单明细DTO
 * 
 * @author simpson
 * 
 */
public class StockOutItemDto extends BaseDto {

    private static final long serialVersionUID = 527064576303866637L;
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
