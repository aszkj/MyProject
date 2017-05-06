package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 微仓定位信息封装实体
 * 
 * @author: chenlian
 * @date: 2016年6月29日 上午12:26:21
 */
public class WarehouseLocationInfo extends BaseModel {

    private static final long serialVersionUID = 2768830166091073688L;

    /**
     * 店铺名称ID
     */
    private Integer storeId;

    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 店铺编号
     */
    private String storeCode;

    /**
     * 距离
     */
    private Long distance;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public Long getDistance() {
        return distance;
    }

    public void setDistance(Long distance) {
        this.distance = distance;
    }

}