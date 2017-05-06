package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品价格记录历史实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_PRICE_HISTORY<br/>
 * 作 者：simpson <br/>
 * 时 间：2015年4月28日上午10:41:43 <br/>
 * Bug的ID：<br/>
 * 修改内容：<br/>
 */
public class ProductPriceHistory extends BaseModel {
    private static final long serialVersionUID = -6823267889841614861L;
    /**
     * ID，自增主键
     */
    private Integer id;
    /**
     * 价格ID，关联产品域产品不同渠道发布价格表P_PRODUCT_PRICE的ID
     */
    private Integer productPriceId;
    /**
     * 产品ID，关联产品域产品基础信息表P_PRODUCT的ID
     */
    private Integer productId;
    /**
     * 修改前促销价，单位厘
     */
    private Long oriPromotionalPrice;
    /**
     * 修改前零售价，单位厘
     */
    private Long oriRetailPrice;
    /**
     * 修改后促销价，单位厘
     */
    private Long promotionalPrice;
    /**
     * 修改后零售价，单位厘
     */
    private Long retailPrice;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 操作用户id
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTPRICEOPERTYPE)
     */
    private String operateType;
    /**
     * 修改前结算金额，单位为厘
     */
    private Long oriCommissionPrice;
    /**
     * 修改后结算金额，单位为厘
     */
    private Long commissionPrice;
    /**
     * 修改前结算金额，单位为厘
     */
    private Long oriCostPrice;
    /**
     * 修改后结算金额，单位为厘
     */
    private Long costPrice;
    /**
     * 修改前结算金额，单位为厘
     */
    private Long oriVipCommissionPrice;
    /**
     * 修改后结算金额，单位为厘
     */
    private Long vipCommissionPrice;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductPriceId() {
        return productPriceId;
    }

    public void setProductPriceId(Integer productPriceId) {
        this.productPriceId = productPriceId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Long getOriPromotionalPrice() {
        return oriPromotionalPrice;
    }

    public void setOriPromotionalPrice(Long oriPromotionalPrice) {
        this.oriPromotionalPrice = oriPromotionalPrice;
    }

    public Long getOriRetailPrice() {
        return oriRetailPrice;
    }

    public void setOriRetailPrice(Long oriRetailPrice) {
        this.oriRetailPrice = oriRetailPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public Long getOriCommissionPrice() {
        return oriCommissionPrice;
    }

    public void setOriCommissionPrice(Long oriCommissionPrice) {
        this.oriCommissionPrice = oriCommissionPrice;
    }

    public Long getCommissionPrice() {
        return commissionPrice;
    }

    public void setCommissionPrice(Long commissionPrice) {
        this.commissionPrice = commissionPrice;
    }

    public Long getOriCostPrice() {
        return oriCostPrice;
    }

    public void setOriCostPrice(Long oriCostPrice) {
        this.oriCostPrice = oriCostPrice;
    }

    public Long getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Long costPrice) {
        this.costPrice = costPrice;
    }

    public Long getOriVipCommissionPrice() {
        return oriVipCommissionPrice;
    }

    public void setOriVipCommissionPrice(Long oriVipCommissionPrice) {
        this.oriVipCommissionPrice = oriVipCommissionPrice;
    }

    public Long getVipCommissionPrice() {
        return vipCommissionPrice;
    }

    public void setVipCommissionPrice(Long vipCommissionPrice) {
        this.vipCommissionPrice = vipCommissionPrice;
    }

}