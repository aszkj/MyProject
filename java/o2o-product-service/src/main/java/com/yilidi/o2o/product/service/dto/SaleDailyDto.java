package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品每日的销售记录Dto <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleDailyDto extends BaseModel {
    private static final long serialVersionUID = -4372070670124787015L;
    /**
     * ID
     */
    private Integer id;
    /**
     * 微仓ID
     */
    private Integer warehouseId;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 供应商产品ID
     */
    private Integer saleProductId;
    /**
     * 产品类别名称
     */
    private String productClassName;
    /**
     * 产品类别编码
     */
    private String productClassCode;
    /**
     * 品牌编码
     */
    private String brandName;
    /**
     * 品牌code
     */
    private String brandCode;
    /**
     * 商品名称
     */
    private String productName;
    /**
     * 销售量
     */
    private Integer saleCount;
    /**
     * 销售额
     */
    private Long amount;
    /**
     * 销售日期
     */
    private Date saleDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getProductClassName() {
        return productClassName;
    }

    public void setProductClassName(String productClassName) {
        this.productClassName = productClassName;
    }

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

}