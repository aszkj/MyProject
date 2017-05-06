package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品出库记录实体类，映射交易域表YiLiDiOrderCenter.T_STOCKOUT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StockOut extends BaseModel {
    private static final long serialVersionUID = -8571423902256563442L;
    /**
     * 出库单编号，主键自增
     */
    private Integer id;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 出库数量
     */
    private Integer stockOutCount;
    /**
     * 出库类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=STOCKOUTTYPE)
     */
    private String stockOutType;
    /**
     * 发货记录ID
     */
    private Integer sendOrderId;
    /**
     * 出库时间
     */
    private Date createTime;
    /**
     * 出库操作人
     */
    private Integer createUserId;
    /**
     * 出库备注
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

    public Integer getStockOutCount() {
        return stockOutCount;
    }

    public void setStockOutCount(Integer stockOutCount) {
        this.stockOutCount = stockOutCount;
    }

    public String getStockOutType() {
        return stockOutType;
    }

    public void setStockOutType(String stockOutType) {
        this.stockOutType = stockOutType;
    }

    public Integer getSendOrderId() {
        return sendOrderId;
    }

    public void setSendOrderId(Integer sendOrderId) {
        this.sendOrderId = sendOrderId;
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