package com.yilidi.o2o.appvo.seller.product;

/**
 * @Description: TODO(商品详细信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:11:31
 */
public class SaleProductDetailVO extends SaleProductBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 8756657377009424523L;
    /**
     * 商品普通价
     */
    private Long retailPrice;
    /**
     * 商品会员价
     */
    private Long promotionalPrice;
    /**
     * 商品销售数量
     */
    private Integer saleCount;
    /**
     * 商品剩余库存数量
     */
    private Integer remainCount;
    /**
     * 产品状态标识 0:下架 1:上架
     */
    private Integer productStatus;

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

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }

}
