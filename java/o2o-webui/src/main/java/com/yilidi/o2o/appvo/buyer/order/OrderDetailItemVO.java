package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单详细产品项目
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class OrderDetailItemVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品图片URL
     */
    private String saleProductImageUrl;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 购买价格
     */
    private Long orderPrice;
    /**
     * 商品购买的数量
     */
    private Integer cartNum;

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Long getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Long orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

}
