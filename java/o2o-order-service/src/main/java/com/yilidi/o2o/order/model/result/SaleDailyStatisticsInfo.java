package com.yilidi.o2o.order.model.result;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品每日的销量统计实体 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleDailyStatisticsInfo extends BaseModel {

    private static final long serialVersionUID = -1257336023902171261L;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品类别名称
     */
    private String productClassName;
    /**
     * 商品类别code
     */
    private String productClassCode;
    /**
     * 品牌名称
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