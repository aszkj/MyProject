package com.yilidi.o2o.appvo.buyer.product;

/**
 * 搜索商品
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class SaleProductSearchVO extends SaleProductBaseVO {

    private static final long serialVersionUID = -5384866170000859035L;
    /** 产品ID **/
    private Integer productId;
    /**
     * 商品条形码
     */
    private String barCode;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

}
