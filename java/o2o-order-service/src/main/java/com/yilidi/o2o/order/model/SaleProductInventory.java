package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品库存实体类，映射产品域表YiLiDiOrderCenter.T_PRODUCT_INVENTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductInventory extends BaseModel {
    private static final long serialVersionUID = 7911929190858241757L;
    /**
     * 库存ID，自增主键
     */
    private Integer id;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 供应商产品ID， 关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
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
     * 是否预警提示标志，当库存达到设置的参数阈值的时候提示预警信息，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=INVENTORYWARNINGFLAG)
     */
    private String warningFlag;
    /**
     * 库存状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=INVENTORYSTORESTATUS)
     */
    private String storeStatus;
    /**
     * 创建用户id
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 最后操作用户ID
     */
    private Integer modifyUserId;
    /**
     * 最后操作时间
     */
    private Date modifyTime;

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

    public String getWarningFlag() {
        return warningFlag;
    }

    public void setWarningFlag(String warningFlag) {
        this.warningFlag = warningFlag;
    }

    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
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

}