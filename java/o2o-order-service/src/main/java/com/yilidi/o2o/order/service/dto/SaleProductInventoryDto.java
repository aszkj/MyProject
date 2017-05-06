package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(商品库存DTO)
 * @author: chenlian
 * @date: 2016年6月22日 上午9:53:40
 */
public class SaleProductInventoryDto extends BaseDto {
    private static final long serialVersionUID = 434455647322939097L;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 库存量,当前的实际量
     */
    private Integer remainCount;
    /**
     * 已订购量
     */
    private Integer orderedCount;
    /**
     * 待发货量
     */
    private Integer standByCount;
    /**
     * 是否预警标志
     */
    private String warningFlag;
    /**
     * 库存状态
     */
    private String storeStatus;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getOrderedCount() {
        return orderedCount;
    }

    public void setOrderedCount(Integer orderedCount) {
        this.orderedCount = orderedCount;
    }

    public Integer getStandByCount() {
        return standByCount;
    }

    public void setStandByCount(Integer standByCount) {
        this.standByCount = standByCount;
    }

    public String getWarningFlag() {
        return warningFlag;
    }

    public void setWarningFlag(String warningFlag) {
        this.warningFlag = warningFlag;
    }

    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
    }

}
