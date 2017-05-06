package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：该表定义店铺商品不同渠道发布的价格，映射商品域表YiLiDiProductCenter.P_SALE_PRODUCT_PRICE <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductPrice extends BaseModel {
    private static final long serialVersionUID = 1765605170285604801L;
    /**
     * 价格ID，自增主键
     */
    private Integer id;
    /**
     * 店铺商品ID，关联产品域店铺商品表P_SALE_PRODUCT的ID
     */
    private Integer saleProductId;
    /**
     * 店铺商品基础促销价，单位厘
     */
    private Long promotionalPrice = 0L;
    /**
     * 店铺商品基础零售价，单位厘
     */
    private Long retailPrice = 0L;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 销售佣金结算金额，单位为厘，默认0
     */
    private Long commissionPrice = 0L;
    /**
     * 进货成本金额，单位为厘，默认0
     */
    private Long costPrice = 0L;
    /**
     * VIP销售佣金结算金额，单位为厘，默认0
     */
    private Long vipCommissionPrice = 0L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
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

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
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