package com.yldbkd.www.seller.android.bean;

import com.yldbkd.www.seller.android.utils.Constants;

/**
 * 商品基础信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class ProductBase extends BaseModel {

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
     * 产品状态标识
     * 见Constants.PRODUCT_STATUS
     * 0:下架
     * 1:上架
     */
    private Integer productStatus;


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

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Integer getProductStatus() {
        return productStatus == null ? Constants.PRODUCT_STATUS.OFFLINE : productStatus;
    }

    public void setProductStatus(Integer productStatus) {
        this.productStatus = productStatus;
    }
}
