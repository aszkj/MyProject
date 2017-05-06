package com.yilidi.o2o.product.model.combination;

import java.util.List;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 楼层与产品关联关系查询信息
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午5:33:09
 */
public class FloorProductInfo extends BaseModel {

    private static final long serialVersionUID = -5818403015244900714L;

    /**
     * 楼层ID
     */
    private Integer floorId;

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
     * 产品类别编码list
     */
    private List<Object> classCodes;
    /**
     * 产品状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
     */
    private String saleStatus;

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
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

    public List<Object> getClassCodes() {
        return classCodes;
    }

    public void setClassCodes(List<Object> classCodes) {
        this.classCodes = classCodes;
    }

}