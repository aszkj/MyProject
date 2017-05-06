/**
 * 文件名称：SaleOrderQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.model.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：出库单查询条件封装类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StockOutOrderQuery extends BaseQuery {

    private static final long serialVersionUID = -2711318109429906879L;
    /**
     * 出库单号
     */
    private String stockOutOrderNo;
    /**
     * 出库单类型
     */
    private String stockOutOrderType;
    /**
     * 出库单号列表
     */
    private List<String> stockOutOrderNoList;

    /**
     * 商户ID
     */
    private Integer storeId;
    /**
     * 商家类型
     */
    private String storeType;

    /**
     * 商户名称
     */
    private String storeName;
    /**
     * 商户编码
     */
    private String storeCode;
    /**
     * 出库单状态
     */
    private String orderStatus;
    /**
     * 出库单开始时间
     */
    private Date beginCreateTime;
    /**
     * 出库单结束时间
     */
    private Date endCreateTime;
    /**
     * 出库单开始审核时间
     */
    private Date beginAuditTime;
    /**
     * 出库单结束审核时间
     */
    private Date endAuditTime;

    public String getStockOutOrderNo() {
        return stockOutOrderNo;
    }

    public void setStockOutOrderNo(String stockOutOrderNo) {
        this.stockOutOrderNo = stockOutOrderNo;
    }

    public String getStockOutOrderType() {
        return stockOutOrderType;
    }

    public void setStockOutOrderType(String stockOutOrderType) {
        this.stockOutOrderType = stockOutOrderType;
    }

    public List<String> getStockOutOrderNoList() {
        return stockOutOrderNoList;
    }

    public void setStockOutOrderNoList(List<String> stockOutOrderNoList) {
        this.stockOutOrderNoList = stockOutOrderNoList;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getBeginCreateTime() {
        return beginCreateTime;
    }

    public void setBeginCreateTime(Date beginCreateTime) {
        this.beginCreateTime = beginCreateTime;
    }

    public Date getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(Date endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public Date getBeginAuditTime() {
        return beginAuditTime;
    }

    public void setBeginAuditTime(Date beginAuditTime) {
        this.beginAuditTime = beginAuditTime;
    }

    public Date getEndAuditTime() {
        return endAuditTime;
    }

    public void setEndAuditTime(Date endAuditTime) {
        this.endAuditTime = endAuditTime;
    }

}