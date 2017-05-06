package com.yldbkd.www.seller.android.bean;

/**
 * 订单详细中所表现的商品信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class ProductOrderItem extends ProductBase {

    /**
     * 商品购买数量
     */
    private Integer cartNum;
    /**
     * 购买时的价格
     */
    private Long currentPrice;

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public Long getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(Long currentPrice) {
        this.currentPrice = currentPrice;
    }

}
