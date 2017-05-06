package com.yilidi.o2o.appvo.buyer.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.appvo.buyer.product.BuyRewardActivityListVO;

/**
 * 购物车商品列表
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class ShopCartSaleProductListVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 商品图片
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
     * 普通会员价格
     */
    private Long retailPrice;
    /**
     * 商品vip价格
     */
    private Long promotionalPrice;
    /**
     * 用户购买价格
     */
    private Long orderPrice;
    /**
     * 产品状态标识 0:下架 1:上架 2:已删除
     */
    private Integer productStatus;
    /**
     * 库存
     */
    private Integer stockNum;
    /**
     * 加入购物车数量
     */
    private Integer cartNum;
    /**
     * 可购数量
     */
    private Integer limitCount;
    /**
     * 活动ID
     */
    private Integer actId;
    /**
     * 商品活动信息列表
     */
    private List<BuyRewardActivityListVO> activityInfoList;

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
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

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }

    public Integer getStockNum() {
        return stockNum;
    }

    public void setStockNum(Integer stockNum) {
        this.stockNum = stockNum;
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

    public Integer getLimitCount() {
        return limitCount;
    }

    public void setLimitCount(Integer limitCount) {
        this.limitCount = limitCount;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

    public List<BuyRewardActivityListVO> getActivityInfoList() {
        return activityInfoList;
    }

    public void setActivityInfoList(List<BuyRewardActivityListVO> activityInfoList) {
        this.activityInfoList = activityInfoList;
    }

}
