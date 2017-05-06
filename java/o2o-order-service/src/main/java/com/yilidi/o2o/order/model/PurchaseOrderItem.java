package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 采购单明细历史变化表，映射交易域表YiLiDiOrderCenter.T_PURCHASE_ORDER_ITEM
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderItem extends BaseModel {

    private static final long serialVersionUID = -1766954744126554788L;

    /**
     * 采购单明细ID，主键自增
     */
    private Integer id;
    /**
     * 采购单编号
     */
    private String purchaseOrderNo;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 采购时产品名称
     */
    private String productName;
    /**
     * 采购时产品条形码
     */
    private String barCode;
    /**
     * 采购时产品规格
     */
    private String specifications;
    /**
     * 采购时产品类别名称
     */
    private String productClassName;
    /**
     * 调拨数量
     */
    private Integer quantity;
    /**
     * 采购商品的价格
     */
    private Long orderPrice;
    /**
     * 采购商品总价
     */
    private Long totalPrice;
    /**
     * 采购时商品列表图URL
     */
    private String productImageUrl3;

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

    public String getProductClassName() {
        return productClassName;
    }

    public void setProductClassName(String productClassName) {
        this.productClassName = productClassName;
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

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
    }

    public String getSpecifications() {
        return specifications;
    }

    public void setSpecifications(String specifications) {
        this.specifications = specifications;
    }

    public Long getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Long orderPrice) {
        this.orderPrice = orderPrice;
    }

    public Long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getProductImageUrl3() {
        return productImageUrl3;
    }

    public void setProductImageUrl3(String productImageUrl3) {
        this.productImageUrl3 = productImageUrl3;
    }

}
