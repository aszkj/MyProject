package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.seller.product.SaleProductBaseVO;

/**
 * @Description: TODO(调货相关商品信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:10:09
 */
public class SaleProductAllotVO extends SaleProductBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -6827848007761662001L;
    /**
     * 产品进货价
     */
    private Long basePrice;
    /**
     * 微仓库存
     */
    private Integer warehouseCount;
    /**
     * 剩余库存
     */
    private Integer remainCount;
    /**
     * 每次调拨操作单位数量
     */
    private Integer perAllotCount;
    /**
     * 商品调拨数量
     */
    private Integer allotCount;
    /**
     * 实际商品调拨数量
     */
    private Integer realAllotCount;
    /**
     * 产品ID
     */
    private Integer productId;

    public Long getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Long basePrice) {
        this.basePrice = basePrice;
    }

    public Integer getWarehouseCount() {
        return warehouseCount;
    }

    public void setWarehouseCount(Integer warehouseCount) {
        this.warehouseCount = warehouseCount;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getPerAllotCount() {
        return perAllotCount;
    }

    public void setPerAllotCount(Integer perAllotCount) {
        this.perAllotCount = perAllotCount;
    }

    public Integer getAllotCount() {
        return allotCount;
    }

    public void setAllotCount(Integer allotCount) {
        this.allotCount = allotCount;
    }

    public Integer getRealAllotCount() {
        return realAllotCount;
    }

    public void setRealAllotCount(Integer realAllotCount) {
        this.realAllotCount = realAllotCount;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

}
