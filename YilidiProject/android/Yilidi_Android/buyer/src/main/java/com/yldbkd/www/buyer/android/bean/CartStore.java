package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 购物车店铺信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class CartStore extends Store {
    /**
     * 送货时间说明
     */
    private String deliveryTimeNote;
    /**
     * 自提时间说明
     */
    private String pickUpTimeNote;
    /**
     * 产品列表
     */
    private List<SaleProduct> saleProductList;

    public String getDeliveryTimeNote() {
        return deliveryTimeNote;
    }

    public void setDeliveryTimeNote(String deliveryTimeNote) {
        this.deliveryTimeNote = deliveryTimeNote;
    }

    public String getPickUpTimeNote() {
        return pickUpTimeNote;
    }

    public void setPickUpTimeNote(String pickUpTimeNote) {
        this.pickUpTimeNote = pickUpTimeNote;
    }

    public List<SaleProduct> getSaleProductList() {
        return saleProductList;
    }

    public void setSaleProductList(List<SaleProduct> saleProductList) {
        this.saleProductList = saleProductList;
    }
}
