package com.yldbkd.www.buyer.android.bean;

/**
 * 购物车的商品和数量信息
 * <p/>
 * Created by linghuxj on 15/11/4.
 */
public class CartInfo extends BaseModel {

    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 购物车数量
     */
    private Integer cartNum;
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

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }
}
