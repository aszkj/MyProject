package com.yilidi.o2o.order.service.dto;

import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 出库单保存DTO
 * 
 * @author chenb
 * 
 */
public class StockOutOrderSaveDto extends BaseDto {
    private static final long serialVersionUID = 8584271249068247737L;

    /**
     * 商户ID
     */
    private Integer storeId;
    /**
     * 出库单类型
     */
    private String stockOutOrderType;

    /**
     * 出库商品及数量
     */
    private List<StockOutOrderSaveItemDto> stockOutOrderSaveItemDtos;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public List<StockOutOrderSaveItemDto> getStockOutOrderSaveItemDtos() {
        return stockOutOrderSaveItemDtos;
    }

    public void setStockOutOrderSaveItemDtos(List<StockOutOrderSaveItemDto> stockOutOrderSaveItemDtos) {
        this.stockOutOrderSaveItemDtos = stockOutOrderSaveItemDtos;
    }

    public String getStockOutOrderType() {
        return stockOutOrderType;
    }

    public void setStockOutOrderType(String stockOutOrderType) {
        this.stockOutOrderType = stockOutOrderType;
    }

}
