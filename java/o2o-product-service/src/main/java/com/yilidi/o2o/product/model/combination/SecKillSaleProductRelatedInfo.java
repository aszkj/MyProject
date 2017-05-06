/**
 * 文件名称：SaleProductRelatedInfo.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.product.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：将秒杀商品相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillSaleProductRelatedInfo extends BaseModel {

    private static final long serialVersionUID = 1918399883043140350L;

    /**
     * 秒杀商品ID
     */
    private Integer id;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 品牌编码
     */
    private String brandCode;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 商品秒杀价格
     */
    private Long secKillProductPrice;
    /**
     * 秒杀商品库存数量
     */
    private Integer remainCount;;
    /**
     * 限购数量,按会员、收货地址、设备号限购，0表示不限购
     */
    private Integer limitOrderCount;
    /**
     * 允许秒中数量
     */
    private Integer secKillCount;
    /**
     * 参与资格
     */
    private String qualifyType;
    /**
     * 抢购时间,单位:秒
     */
    private Long secKillTime;
    /**
     * 场次关联的秒杀商品状态
     */
    private String statusCode;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public Long getSecKillProductPrice() {
        return secKillProductPrice;
    }

    public void setSecKillProductPrice(Long secKillProductPrice) {
        this.secKillProductPrice = secKillProductPrice;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getLimitOrderCount() {
        return limitOrderCount;
    }

    public void setLimitOrderCount(Integer limitOrderCount) {
        this.limitOrderCount = limitOrderCount;
    }

    public Integer getSecKillCount() {
        return secKillCount;
    }

    public void setSecKillCount(Integer secKillCount) {
        this.secKillCount = secKillCount;
    }

    public String getQualifyType() {
        return qualifyType;
    }

    public void setQualifyType(String qualifyType) {
        this.qualifyType = qualifyType;
    }

    public Long getSecKillTime() {
        return secKillTime;
    }

    public void setSecKillTime(Long secKillTime) {
        this.secKillTime = secKillTime;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

}