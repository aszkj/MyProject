/**
 * 文件名称：SaleOrderItemDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderItemInfoProxyDto extends BaseDto {

    private static final long serialVersionUID = -6198480817544003640L;
    /**
     * 订单编号，可调用StringUtils.generateOrderNo()生成
     */
    private String saleOrderNo;
    /**
     * 买家CUSTOMERID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_BUYER）
     */
    private Integer buyerCustomerId;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;

    /**
     * 下单的用户ID，如果是买家用户就是买家的用户ID，如果后台有操作的，则为后台或者店家的登录用户ID
     */
    private Integer userId;
    /**
     * 订单类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERTYPE)
     */
    private String typeCode;
    /**
     * 订单状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERSTATUS)
     */
    private String statusCode;
    /**
     * 商品id
     */
    private Integer saleProductId;
    /**
     * 商品数量
     */
    private Integer quantity;
    /**
     * 收货时间
     */
    private Date takeTime;

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Date getTakeTime() {
        return takeTime;
    }

    public void setTakeTime(Date takeTime) {
        this.takeTime = takeTime;
    }

}
