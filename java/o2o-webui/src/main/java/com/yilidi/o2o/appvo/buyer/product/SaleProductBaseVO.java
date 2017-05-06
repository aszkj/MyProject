package com.yilidi.o2o.appvo.buyer.product;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 搜索商品
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class SaleProductBaseVO extends AppBaseVO {

    private static final long serialVersionUID = -3179403187975945255L;
    /** 商品ID **/
    private Integer saleProductId;
    /**
     * 产品ID
     */
    private Integer productId;
    /** 商品品牌名称 **/
    private String brandName;
    /** 商品名称 **/
    private String saleProductName;
    /** 商品图片url **/
    private String saleProductImageUrl;
    /** 普通会员价格 **/
    private Long retailPrice;
    /** vip会员价格 **/
    private Long promotionalPrice;
    /**
     * 当前用户购买价格
     */
    private Long orderPrice;
    /** 库存数量  **/
    private Integer stockNum;
    /** 商品规格 **/
    private String saleProductSpec;
    /** 是否用户已经收藏 **/
    private Integer isCollected;
    
    public Integer getIsCollected() {
        return isCollected;
    }

    public void setIsCollected(Integer isCollected) {
        this.isCollected = isCollected;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Long orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Integer getStockNum() {
        return stockNum;
    }

    public void setStockNum(Integer stockNum) {
        this.stockNum = stockNum;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }
}
