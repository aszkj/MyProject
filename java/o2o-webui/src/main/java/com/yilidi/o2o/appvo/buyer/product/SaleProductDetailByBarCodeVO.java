package com.yilidi.o2o.appvo.buyer.product;

/**
 * 搜索商品
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class SaleProductDetailByBarCodeVO extends SaleProductBaseVO {

    private static final long serialVersionUID = -7445302726798352682L;
    /** 商品详情数据信息 **/
    private String productDetail;
    /*** 产品状态标识 0:下架 1:上架 2:已删除 **/
    private Integer productStatus;

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

}
