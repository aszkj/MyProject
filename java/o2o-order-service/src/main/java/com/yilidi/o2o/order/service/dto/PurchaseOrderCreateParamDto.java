package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 创建采购单前台传过来的参数DTO
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderCreateParamDto extends BaseDto {

    private static final long serialVersionUID = -2111972601728099168L;
    /**
     * 微仓ID
     */
    private String storeId;
    /**
     * 产品明细组合字符串
     */
    private String productItems;

    public String getStoreId() {
        return storeId;
    }

    public void setStoreId(String storeId) {
        this.storeId = storeId;
    }

    public String getProductItems() {
        return productItems;
    }

    public void setProductItems(String productItems) {
        this.productItems = productItems;
    }

}
