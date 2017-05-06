package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 调拨单保存DTO
 * 
 * @author simpson
 * 
 */
public class FlittingOrderSaveItemDto extends BaseDto {
    private static final long serialVersionUID = 9010198005569327942L;
    /**
     * 调出商品ID
     */
    private Integer srcSaleProductId;
    /**
     * 调货数量
     */
    private Integer flittingCount;

    public Integer getSrcSaleProductId() {
        return srcSaleProductId;
    }

    public void setSrcSaleProductId(Integer srcSaleProductId) {
        this.srcSaleProductId = srcSaleProductId;
    }

    public Integer getFlittingCount() {
        return flittingCount;
    }

    public void setFlittingCount(Integer flittingCount) {
        this.flittingCount = flittingCount;
    }

}
