package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 加入购物车业务判断VO
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class AsycnChangeCartVO extends AppBaseVO {

    private static final long serialVersionUID = 2803910838254325663L;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品购物车数量
     */
    private Integer cartNum;
    /**
     * 当前用户结算时商品价格
     */
    private Long orderPrice;
    /**
     * 商品活动ID
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

    public Long getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Long orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

}
