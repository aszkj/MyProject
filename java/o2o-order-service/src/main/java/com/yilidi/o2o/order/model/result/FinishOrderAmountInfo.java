package com.yilidi.o2o.order.model.result;

import com.yilidi.o2o.core.model.BaseModel;

public class FinishOrderAmountInfo extends BaseModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7185579307802183692L;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 销售总额
     */
    private Long sumOrderAmount;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Long getSumOrderAmount() {
        return sumOrderAmount;
    }

    public void setSumOrderAmount(Long sumOrderAmount) {
        this.sumOrderAmount = sumOrderAmount;
    }

}
