package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 9:19
 * @描述 品牌信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ProductImage extends BaseModel {
    /**
     * 商品图片
     */
    private String saleProductImageUrl;

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }
}
