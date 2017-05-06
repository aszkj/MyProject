package com.yilidi.o2o.appvo.buyer.product;

/**
 * 搜索商品
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class ProductFavoriteVO extends SaleProductBaseVO {

    private static final long serialVersionUID = 8703088316354697898L;
    /**
     * 商品状态标识 0：下架 1：上架 2：已删除 3：已过期
     */
    private Integer productStatus;

    public Integer getProductStatus() {
        return productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }
}
