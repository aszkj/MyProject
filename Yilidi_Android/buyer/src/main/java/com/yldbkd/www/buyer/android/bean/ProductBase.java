package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * @author 李贞高
 * @version $Rev$
 * @time 2016/9/7 11:57
 * @des 商品基本数据
 * @updateAuthor $Author$
 * @updateDate $Date$
 * @updateDes
 */
public class ProductBase extends BaseModel {
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 商品主图片url
     */
    private String saleProductImageUrl;
    /**
     * 商品图片集url
     */
    private List<ProductImage> saleProductImageList;
    /**
     * 库存数量
     */
    private Integer stockNum = 0;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 购买时商品单价
     */
    private Long orderPrice;
    /**
     * 商品详细信息-web形式进行
     */
    private String productDetail;
    /**
     * 商品状态标识
     * 0:下架
     * 1:上架
     * 2:已删除
     */
    private Integer productStatus;
    /**
     * 加入购物车数量
     */
    private Integer cartNum = 0;
    /**
     * 活动Id
     */
    private Integer actId;
    /**
     * 商品限制购买数量
     */
    private Integer limitCount;
    /**
     * 是否用户已经收藏
     * 0：未收藏
     * 1：已收藏
     */
    private Integer isCollected;

    public ProductBase() {
    }

    public ProductBase(int saleProductId, int cartNum, String productName, Long orderPrice, int actId) {
        this();
        this.saleProductId = saleProductId;
        this.cartNum = cartNum;
        this.saleProductName = productName;
        this.orderPrice = orderPrice;
        this.actId = actId;
    }

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

    public Long getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Long orderPrice) {
        this.orderPrice = orderPrice;
    }

    public String getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(String productDetail) {
        this.productDetail = productDetail;
    }

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
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

    public Integer getLimitCount() {
        return limitCount;
    }

    public void setLimitCount(Integer limitCount) {
        this.limitCount = limitCount;
    }

    public List<ProductImage> getSaleProductImageList() {
        return saleProductImageList;
    }

    public void setSaleProductImageList(List<ProductImage> saleProductImageList) {
        this.saleProductImageList = saleProductImageList;
    }

    public Integer getIsCollected() {
        return isCollected;
    }

    public void setIsCollected(Integer isCollected) {
        this.isCollected = isCollected;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }
}
