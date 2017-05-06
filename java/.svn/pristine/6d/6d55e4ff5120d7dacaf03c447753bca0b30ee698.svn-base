package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 店铺各个金额汇总
 * 
 * @author simpson
 * 
 */
public class StoreTotalPrice extends BaseDto {

    private static final long serialVersionUID = 7383526668864691403L;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 根据零售金额汇总
     */
    private Long totalRetailPrice = 0L;
    /**
     * 根据促销金额汇总
     */
    private Long totalPromotionPrice = 0L;
    /**
     * 根据成本金额汇总
     */
    private Long totalCostPrice = 0L;

    /**
     * 默认构造器
     */
    public StoreTotalPrice() {
    }

    /**
     * 构造器
     * 
     * @param storeId
     *            店铺ID
     */
    public StoreTotalPrice(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Long getTotalRetailPrice() {
        return totalRetailPrice;
    }

    public void setTotalRetailPrice(Long totalRetailPrice) {
        this.totalRetailPrice = totalRetailPrice;
    }

    public Long getTotalPromotionPrice() {
        return totalPromotionPrice;
    }

    public void setTotalPromotionPrice(Long totalPromotionPrice) {
        this.totalPromotionPrice = totalPromotionPrice;
    }

    public Long getTotalCostPrice() {
        return totalCostPrice;
    }

    public void setTotalCostPrice(Long totalCostPrice) {
        this.totalCostPrice = totalCostPrice;
    }

}
