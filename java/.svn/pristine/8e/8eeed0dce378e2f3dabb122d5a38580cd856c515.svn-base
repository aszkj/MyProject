package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：入库串号实体类，映射产品域表YiLiDiOrderCenter.P_STOCKIN_IMEI <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StockInImei extends BaseModel {
    private static final long serialVersionUID = 2347127247961574999L;
    /**
     * id, 自增主键
     */
    private Integer id;
    /**
     * 入库记录明细ID， 关联产品域入库单表T_STOCKIN_ITEM的ID字段
     */
    private Integer stockInItemId;
    /**
     * 串号,关联商品串号表T_PRODUCT_IMEI的IMEINO字段
     */
    private String imeiNo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStockInItemId() {
        return stockInItemId;
    }

    public void setStockInItemId(Integer stockInItemId) {
        this.stockInItemId = stockInItemId;
    }

    public String getImeiNo() {
        return imeiNo;
    }

    public void setImeiNo(String imeiNo) {
        this.imeiNo = imeiNo;
    }
}