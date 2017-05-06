/**
 * 文件名称：ShopCartProxyDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ShopCartProxyDto extends BaseDto {

    private static final long serialVersionUID = 7315957225423662171L;
    /**
     * 用户ID,关联用户域U_USER表的USERID字段
     */
    private Integer userId;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 活动ID
     */
    private Integer activityId;

    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 商品数量
     */
    private Integer quantity;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
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

}
