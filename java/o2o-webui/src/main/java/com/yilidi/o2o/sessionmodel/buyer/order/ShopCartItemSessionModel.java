package com.yilidi.o2o.sessionmodel.buyer.order;

import java.io.Serializable;

/**
 * 功能描述：购物车商品列表信息缓存类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ShopCartItemSessionModel implements Serializable {

    private static final long serialVersionUID = 3177710438456463007L;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 商品数量
     */
    private Integer quantity;
    /**
     * 活动ID
     */
    private Integer actId;

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

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
