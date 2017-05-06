package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：库存历史实体类，映射产品域表YiLiDiOrderCenter.T_PRODUCT_INVESTORY_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductInventoryHistory extends BaseModel {

    private static final long serialVersionUID = -7398401663952719097L;

    /**
     * 记录id，自增主键
     */
    private Integer id;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 商品id
     */
    private Integer saleProductId;
    /**
     * 前库存量
     */
    private Integer preRemainCount;
    /**
     * 前已订购量
     */
    private Integer preOrderedCount;
    /**
     * 前待发货量
     */
    private Integer preStandbyCount;
    /**
     * 库存量，当前的实际库存量
     */
    private Integer remainCount;
    /**
     * 已订购量，已订购的商品数量
     */
    private Integer orderedCount;
    /**
     * 待发货量：已订购且已付款的产品数量（<= ORDEREDCOUNT）
     */
    private Integer standbyCount;
    /**
     * 库存变化量
     */
    private Integer delta;
    /**
     * 库存变化操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=INVENTORYOPERTYPE)
     */
    private String operateType;
    /**
     * 关联的单号
     */
    private String relativeNo;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作用户id
     */
    private Integer operateUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getPreRemainCount() {
        return preRemainCount;
    }

    public void setPreRemainCount(Integer preRemainCount) {
        this.preRemainCount = preRemainCount;
    }

    public Integer getPreOrderedCount() {
        return preOrderedCount;
    }

    public void setPreOrderedCount(Integer preOrderedCount) {
        this.preOrderedCount = preOrderedCount;
    }

    public Integer getPreStandbyCount() {
        return preStandbyCount;
    }

    public void setPreStandbyCount(Integer preStandbyCount) {
        this.preStandbyCount = preStandbyCount;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getOrderedCount() {
        return orderedCount;
    }

    public void setOrderedCount(Integer orderedCount) {
        this.orderedCount = orderedCount;
    }

    public Integer getStandbyCount() {
        return standbyCount;
    }

    public void setStandbyCount(Integer standbyCount) {
        this.standbyCount = standbyCount;
    }

    public Integer getDelta() {
        return delta;
    }

    public void setDelta(Integer delta) {
        this.delta = delta;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public String getRelativeNo() {
        return relativeNo;
    }

    public void setRelativeNo(String relativeNo) {
        this.relativeNo = relativeNo;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

}