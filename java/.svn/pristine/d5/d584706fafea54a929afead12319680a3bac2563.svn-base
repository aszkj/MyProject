package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品入库记录实体类，映射产品域表YiLiDiOrderCenter.T_STOCKIN<br/>
 * 作 者：simpson <br/>
 * 
 * Bug的ID：<br/>
 * 修改内容：<br/>
 */
public class StockIn extends BaseModel {
    private static final long serialVersionUID = 5464061361932777480L;
    /**
     * 入库记录ID，自增主键
     */
    private Integer id;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 入库数量
     */
    private Integer stockInCount;
    /**
     * 入库类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=STOCKINTYPE)
     */
    private String stockInType;
    /**
     * 创建时间（入库时间）
     */
    private Date createTime;
    /**
     * 创建用户ID（入库操作用户ID）
     */
    private Integer createUserId;
    /**
     * 入库备注
     */
    private String note;

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

    public Integer getStockInCount() {
        return stockInCount;
    }

    public void setStockInCount(Integer stockInCount) {
        this.stockInCount = stockInCount;
    }

    public String getStockInType() {
        return stockInType;
    }

    public void setStockInType(String stockInType) {
        this.stockInType = stockInType;
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

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}