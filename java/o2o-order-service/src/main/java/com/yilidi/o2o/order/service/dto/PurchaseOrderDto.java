package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 采购单
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderDto extends BaseDto {

    private static final long serialVersionUID = -8803194709817406129L;
    /**
     * 采购单ID，主键自增
     */
    private Integer id;
    /**
     * 采购单编号
     */
    private String purchaseOrderNo;
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
     * 采购商品数量
     */
    private Integer purchaseCount;
    /**
     * 采购商品金额，单位为厘
     */
    private Long purchaseAmount;
    /**
     * 省份编码
     */
    private String provinceCode;
    /**
     * 市编码
     */
    private String cityCode;
    /**
     * 地区编码
     */
    private String countyCode;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 采购单备注
     */
    private String note;
    /**
     * 采购单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PURCHASEORDERSTATUS)
     */
    private String orderStatus;
    /**
     * 采购单状态
     */
    private String orderStatusName;
    /**
     * 采购单更新时间
     */
    private Date updateTime;
    /**
     * 采购单更新用户ID
     */
    private Integer updateUserId;
    /**
     * 采购单审核时间
     */
    private Date auditTime;
    /**
     * 采购单审核用户ID
     */
    private Integer auditUserId;
    /**
     * 审核人用户名
     */
    private String auditUserName;

    /**
     * 采购单审核不通过原因
     */
    private String auditRejectReason;
    /**
     * 采购单地址信息
     */
    private PurchaseOrderAddressDto purchaseOrderAddressDto;
    /**
     * 采购单明细
     */
    private List<PurchaseOrderItemDto> purchaseOrderItemDtoList;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
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

    public Integer getPurchaseCount() {
        return purchaseCount;
    }

    public void setPurchaseCount(Integer purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    public Long getPurchaseAmount() {
        return purchaseAmount;
    }

    public void setPurchaseAmount(Long purchaseAmount) {
        this.purchaseAmount = purchaseAmount;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
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

    public PurchaseOrderAddressDto getPurchaseOrderAddressDto() {
        return purchaseOrderAddressDto;
    }

    public void setPurchaseOrderAddressDto(PurchaseOrderAddressDto purchaseOrderAddressDto) {
        this.purchaseOrderAddressDto = purchaseOrderAddressDto;
    }

    public List<PurchaseOrderItemDto> getPurchaseOrderItemDtoList() {
        return purchaseOrderItemDtoList;
    }

    public void setPurchaseOrderItemDtoList(List<PurchaseOrderItemDto> purchaseOrderItemDtoList) {
        this.purchaseOrderItemDtoList = purchaseOrderItemDtoList;
    }

}
