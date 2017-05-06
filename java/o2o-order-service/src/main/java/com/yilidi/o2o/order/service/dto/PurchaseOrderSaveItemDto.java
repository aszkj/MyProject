package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 采购单保存DTO
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderSaveItemDto extends BaseDto {
    private static final long serialVersionUID = 4687240769301985421L;
    /**
     * 采购产品ID
     */
    private Integer productId;
    /**
     * 采购数量
     */
    private Integer purchaseCount;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(Integer purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

}
