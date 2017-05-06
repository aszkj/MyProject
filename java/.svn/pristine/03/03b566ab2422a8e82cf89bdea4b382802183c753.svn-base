package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：购物车实体类，映射产品域表YiLiDiProductCenter.P_SHOP_CART <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ShopCart extends BaseModel {
    private static final long serialVersionUID = -612403125734740568L;
    /**
     * 购物车ID，自增主键
     */
    private Integer id;
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
    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date createTime;
    /**
     * 创建时间，用户添加购物车的时间
     */
    private Date modifyTime;
    /**
     * 用户操作SESSIONID，供以后扩展使用，目前默认为NULL
     */
    private String sessionId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

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

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

}