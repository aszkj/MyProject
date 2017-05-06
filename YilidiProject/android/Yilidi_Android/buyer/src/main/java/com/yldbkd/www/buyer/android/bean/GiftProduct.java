package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 9:56
 * @描述  买赠商品信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class GiftProduct extends BaseModel {
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
     * 品牌名称
     */
    private String brandName;
    /**
     * 商品单价
     */
    private Long orderPrice;
    /**
     * 商品赠送的数量
     */
    private Integer cartNum;
    /**
     * 商品规格
     */
    private String saleProductSpec;

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
}
