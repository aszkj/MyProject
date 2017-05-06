package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 出库单出库关联信息，映射交易域表YiLiDiOrderCenter.T_STOCKOUT_ORDER_STOCKOUT_RELATION
 * 
 * @author chenb
 * 
 */
public class StockOutOrderStockOutRelation extends BaseModel {

    private static final long serialVersionUID = 996329468401758593L;
    /**
     * 出库单出库信息关联ID，主键自增
     */
    private Integer id;
    /**
     * 出库出库操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=STOCKOUTORDERTOCKOUTOPERTYPE)
     */
    private String stockOutOperType;
    /**
     * 出库单编号
     */
    private String stockOutOrderNo;
    /**
     * 出库单ID
     */
    private Integer stockOutId;
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

    public String getStockOutOperType() {
        return stockOutOperType;
    }

    public void setStockOutOperType(String stockOutOperType) {
        this.stockOutOperType = stockOutOperType;
    }

    public String getStockOutOrderNo() {
        return stockOutOrderNo;
    }

    public void setStockOutOrderNo(String stockOutOrderNo) {
        this.stockOutOrderNo = stockOutOrderNo;
    }

    public Integer getStockOutId() {
        return stockOutId;
    }

    public void setStockOutId(Integer stockOutId) {
        this.stockOutId = stockOutId;
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
