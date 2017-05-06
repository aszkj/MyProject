package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 调货单入库单关联信息，映射交易域表YiLiDiOrderCenter.T_FLITTING_STOCKIN_RELATION
 * 
 * @author simpson
 * 
 */
public class FlittingStockInRelation extends BaseModel {

    private static final long serialVersionUID = -2468660078614677309L;
    /**
     * 调拨单入库信息关联ID，主键自增
     */
    private Integer id;
    /**
     * 调拨入库操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=FLITTINGSTOCKINOPERTYPE)
     */
    private String flittingOperType;
    /**
     * 调拨单编号
     */
    private String flittingOrderNo;
    /**
     * 入库单ID
     */
    private Integer stockInId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFlittingOperType() {
        return flittingOperType;
    }

    public void setFlittingOperType(String flittingOperType) {
        this.flittingOperType = flittingOperType;
    }

    public String getFlittingOrderNo() {
        return flittingOrderNo;
    }

    public void setFlittingOrderNo(String flittingOrderNo) {
        this.flittingOrderNo = flittingOrderNo;
    }

    public Integer getStockInId() {
        return stockInId;
    }

    public void setStockInId(Integer stockInId) {
        this.stockInId = stockInId;
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

}
