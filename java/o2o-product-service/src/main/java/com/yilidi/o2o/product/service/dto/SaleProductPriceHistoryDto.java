/**
 * 文件名称：SaleProductPriceHistoryDto.java
 * 
 * 描述：商品历史价格模型Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品历史价格模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductPriceHistoryDto extends BaseDto {
    private static final long serialVersionUID = -1745349913089846754L;
    /**
     * ID，自增主键
     */
    private Integer id;
    /**
     * 店铺价格ID
     */
    private Integer saleProductPriceId;
    /**
     * 店铺商品ID
     */
    private Integer saleProductId;
    /**
     * 店铺商品修改前的促销价，单位厘
     */
    private Long oriPromotionalPrice;
    /**
     * 店铺商品修改后的促销价，单位厘
     */
    private Long promotionalPrice;
    /**
     * 店铺商品修改前的零售价，单位厘
     */
    private Long oriRetailPrice;
    /**
     * 店铺商品修改后的零售价，单位厘
     */
    private Long retailPrice;
    /**
     * 渠道编码
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
     * 操作类型
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

    public Integer getSaleProductPriceId() {
        return saleProductPriceId;
    }

    public void setSaleProductPriceId(Integer saleProductPriceId) {
        this.saleProductPriceId = saleProductPriceId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Long getOriPromotionalPrice() {
        return oriPromotionalPrice;
    }

    public void setOriPromotionalPrice(Long oriPromotionalPrice) {
        this.oriPromotionalPrice = oriPromotionalPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getOriRetailPrice() {
        return oriRetailPrice;
    }

    public void setOriRetailPrice(Long oriRetailPrice) {
        this.oriRetailPrice = oriRetailPrice;
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