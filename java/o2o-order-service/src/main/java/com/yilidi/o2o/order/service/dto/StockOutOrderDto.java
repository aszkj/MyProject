package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 出库单
 * 
 * @author chenb
 * 
 */
public class StockOutOrderDto extends BaseDto {

    private static final long serialVersionUID = -8803194709817406129L;
    /**
     * 出库单ID，主键自增
     */
    private Integer id;
    /**
     * 出库单编号
     */
    private String stockOutOrderNo;
    /**
     * 商户ID
     */
    private Integer storeId;
    /**
     * 商家类型
     */
    private String storeType;
    /**
     * 商家类型名称
     */
    private String storeTypeName;
    /**
     * 商户名称
     */
    private String storeName;
    /**
     * 商户编码
     */
    private String storeCode;
    /**
     * 商户详细地址
     */
    private String addressDetail;
    /**
     * 出库单类型
     */
    private String stockOutOrderType;
    /**
     * 出库单类型名称
     */
    private String stockOutOrderTypeName;
    /**
     * 出库商品数量
     */
    private Integer stockOutCount;
    /**
     * 出库商品金额，单位为厘
     */
    private Long stockOutAmount;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建用户名
     */
    private String createUserName;
    /**
     * 出库单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=STOCKOUTORDERSTATUS)
     */
    private String orderStatus;
    /**
     * 出库单状态
     */
    private String orderStatusName;
    /**
     * 出库单更新时间
     */
    private Date updateTime;
    /**
     * 出库单更新用户ID
     */
    private Integer updateUserId;
    /**
     * 最后修改用户名称
     */
    private String updateUserName;
    /**
     * 出库单审核时间
     */
    private Date auditTime;
    /**
     * 出库单审核用户ID
     */
    private Integer auditUserId;
    /**
     * 审核人用户名
     */
    private String auditUserName;

    /**
     * 出库单审核不通过原因
     */
    private String auditRejectReason;
    /**
     * 出库单明细
     */
    private List<StockOutOrderItemDto> stockOutOrderItemDtos;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStockOutOrderNo() {
        return stockOutOrderNo;
    }

    public void setStockOutOrderNo(String stockOutOrderNo) {
        this.stockOutOrderNo = stockOutOrderNo;
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

    public String getStoreTypeName() {
        return storeTypeName;
    }

    public void setStoreTypeName(String storeTypeName) {
        this.storeTypeName = storeTypeName;
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

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getStockOutOrderType() {
        return stockOutOrderType;
    }

    public void setStockOutOrderType(String stockOutOrderType) {
        this.stockOutOrderType = stockOutOrderType;
    }

    public String getStockOutOrderTypeName() {
        return stockOutOrderTypeName;
    }

    public void setStockOutOrderTypeName(String stockOutOrderTypeName) {
        this.stockOutOrderTypeName = stockOutOrderTypeName;
    }

    public Integer getStockOutCount() {
        return stockOutCount;
    }

    public void setStockOutCount(Integer stockOutCount) {
        this.stockOutCount = stockOutCount;
    }

    public Long getStockOutAmount() {
        return stockOutAmount;
    }

    public void setStockOutAmount(Long stockOutAmount) {
        this.stockOutAmount = stockOutAmount;
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

    public String getCreateUserName() {
        return createUserName;
    }

    public void setCreateUserName(String createUserName) {
        this.createUserName = createUserName;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOrderStatusName() {
        return orderStatusName;
    }

    public void setOrderStatusName(String orderStatusName) {
        this.orderStatusName = orderStatusName;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public String getUpdateUserName() {
        return updateUserName;
    }

    public void setUpdateUserName(String updateUserName) {
        this.updateUserName = updateUserName;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public Integer getAuditUserId() {
        return auditUserId;
    }

    public void setAuditUserId(Integer auditUserId) {
        this.auditUserId = auditUserId;
    }

    public String getAuditUserName() {
        return auditUserName;
    }

    public void setAuditUserName(String auditUserName) {
        this.auditUserName = auditUserName;
    }

    public String getAuditRejectReason() {
        return auditRejectReason;
    }

    public void setAuditRejectReason(String auditRejectReason) {
        this.auditRejectReason = auditRejectReason;
    }

    public List<StockOutOrderItemDto> getStockOutOrderItemDtos() {
        return stockOutOrderItemDtos;
    }

    public void setStockOutOrderItemDtos(List<StockOutOrderItemDto> stockOutOrderItemDtos) {
        this.stockOutOrderItemDtos = stockOutOrderItemDtos;
    }

}
