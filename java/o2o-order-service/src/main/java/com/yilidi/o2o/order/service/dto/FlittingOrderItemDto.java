package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 调拨单明细
 * 
 * @author simpson
 * 
 */
public class FlittingOrderItemDto extends BaseDto {

    private static final long serialVersionUID = -8945899146250970278L;
    /**
     * 调拨单明细ID，主键自增
     */
    private Integer id;
    /**
     * 调拨单编号
     */
    private String flittingOrderNo;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 调拨时产品类别名称
     */
    private String productClassName;
    /**
     * 调拨时产品品牌名称
     */
    private String brandName;
    /**
     * 调拨时产品规格
     */
    private String specifications;
    /**
     * 调拨时产品名称
     */
    private String productName;
    /**
     * 调拨时产品条形码
     */
    private String barCode;
    /**
     * 调拨数量
     */
    private Integer quantity;
    /**
     * 调出商品ID
     */
    private Integer srcSaleProductId;
    /**
     * 调入商品ID
     */
    private Integer destSaleProductId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 调拨接收数量
     */
    private Integer receiveQuantity;
    /**
     * 调拨拒绝数量
     */
    private Integer rejectQuantity;
    /**
     * 更新时间
     */
    private Date updateTime;
    /**
     * 更新用户ID
     */
    private Integer updateUserId;
    /**
     * 下单时商品列表图URL
     */
    private String productImageUrl3;
    /**
     * 商品成本价格
     */
    private String costPrice;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFlittingOrderNo() {
        return flittingOrderNo;
    }

    public void setFlittingOrderNo(String flittingOrderNo) {
        this.flittingOrderNo = flittingOrderNo;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
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

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
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

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Integer getSrcSaleProductId() {
        return srcSaleProductId;
    }

    public void setSrcSaleProductId(Integer srcSaleProductId) {
        this.srcSaleProductId = srcSaleProductId;
    }

    public Integer getDestSaleProductId() {
        return destSaleProductId;
    }

    public void setDestSaleProductId(Integer destSaleProductId) {
        this.destSaleProductId = destSaleProductId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getReceiveQuantity() {
        return receiveQuantity;
    }

    public void setReceiveQuantity(Integer receiveQuantity) {
        this.receiveQuantity = receiveQuantity;
    }

    public Integer getRejectQuantity() {
        return rejectQuantity;
    }

    public void setRejectQuantity(Integer rejectQuantity) {
        this.rejectQuantity = rejectQuantity;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getProductImageUrl3() {
        return productImageUrl3;
    }

    public void setProductImageUrl3(String productImageUrl3) {
        this.productImageUrl3 = productImageUrl3;
    }

    public String getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(String costPrice) {
        this.costPrice = costPrice;
    }

}
