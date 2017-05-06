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
 * 功能描述：采购单查询条件封装类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PurchaseOrderQuery extends BaseQuery {
    private static final long serialVersionUID = 7681492515562233746L;

    /**
     * 采购单号
     */
    private String purchaseOrderNo;
    /**
     * 采购单号列表
     */
    private List<String> purchaseOrderNoList;

    /**
     * 微仓ID
     */
    private Integer storeId;

    /**
     * 微仓名称
     */
    private String storeName;
    /**
     * 微仓编码
     */
    private String storeCode;
    /**
     * 收货人手机号码
     */
    private String phoneNo;
    /**
     * 采购单状态
     */
    private String orderStatus;
    /**
     * 采购单开始时间
     */
    private Date beginCreateTime;
    /**
     * 采购单结束时间
     */
    private Date endCreateTime;
    /**
     * 采购单开始审核时间
     */
    private Date beginAuditTime;
    /**
     * 采购单结束审核时间
     */
    private Date endAuditTime;

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
    }

    public List<String> getPurchaseOrderNoList() {
        return purchaseOrderNoList;
    }

    public void setPurchaseOrderNoList(List<String> purchaseOrderNoList) {
        this.purchaseOrderNoList = purchaseOrderNoList;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
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

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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