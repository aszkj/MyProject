/**
 * 文件名称：SaleProductDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.proxy.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品信息代理类DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductPriceProxyDto extends BaseDto {

    private static final long serialVersionUID = -1516830773387011123L;
    /**
     * 店铺商品ID，关联产品域店铺商品表P_SALE_PRODUCT的ID
     */
    private Integer saleProductId;
    /**
     * 普通会员价格
     */
    private Long retailPrice;
    /**
     * 商品促销价格
     */
    private Long promotionalPrice;
    /**
     * 销售佣金结算金额
     */
    private Long commissionPrice;
    /**
     * 进货成本金额，单位为厘，默认0
     */
    private Long costPrice;
    /**
     * VIP销售佣金结算金额，单位为厘，默认0
     */
    private Long vipCommissionPrice;

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getCommissionPrice() {
        return commissionPrice;
    }

    public void setCommissionPrice(Long commissionPrice) {
        this.commissionPrice = commissionPrice;
    }

    public Long getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Long costPrice) {
        this.costPrice = costPrice;
    }

    public Long getVipCommissionPrice() {
        return vipCommissionPrice;
    }

    public void setVipCommissionPrice(Long vipCommissionPrice) {
        this.vipCommissionPrice = vipCommissionPrice;
    }

}
