package com.yilidi.o2o.product.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 专题栏目与产品关联关系查询信息
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午3:58:46
 */
public class ThemeColumnProductInfo extends BaseModel {

    private static final long serialVersionUID = -5818403015244900714L;

    /**
     * 专题栏目ID
     */
    private Integer themeColumnId;

    /**
     * 产品名称
     */
    private String productName;

    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;

    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;

    /**
     * 产品状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
     */
    private String saleStatus;

    public Integer getThemeColumnId() {
        return themeColumnId;
    }

    public void setThemeColumnId(Integer themeColumnId) {
        this.themeColumnId = themeColumnId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

}