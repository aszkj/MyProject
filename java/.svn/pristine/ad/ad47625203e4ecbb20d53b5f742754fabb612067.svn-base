package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品串口日志实体类，映射产品域表YiLiDiOrderCenter.T_PRODUCT_IMEI_LOG <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductImeiLog extends BaseModel {
    private static final long serialVersionUID = 4550488655065063829L;
    /**
     * 日志ID
     */
    private Integer id;
    /**
     * 供应商ID， 关联用户域客户表U_CUSTOMER的CUSTOMERID字段(CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer providerId;
    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 品牌编码, 关联产品域P_PRODUCT_BRAND表的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 型号编码，关联产品域品牌表P_PRODUCT_MODEL的MODELCODE字段
     */
    private String modelCode;
    /**
     * 串号
     */
    private String imeiNo;
    /**
     * 串号状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTIMEISTATUS)
     */
    private String imeiStatusCode;
    /**
     * 操作人
     */
    private Integer operateUserId;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTIMEIOPERTYPE)
     */
    private String operateType;
    /**
     * 入库记录明细ID，关联产品域表T_STOCKIN_ITEM的ID字段
     */
    private Integer stockInItemId;
    /**
     * 出库记录明细ID，关联产品域表T_STOCKOUT_ITEM的ID字段
     */
    private Integer stockOutItemId;
    /**
     * 订单编号，关联交易域订单表T_SALE_ORDER的SALEORDERNO字段
     */
    private String saleOrderNo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProviderId() {
        return providerId;
    }

    public void setProviderId(Integer providerId) {
        this.providerId = providerId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public String getModelCode() {
        return modelCode;
    }

    public void setModelCode(String modelCode) {
        this.modelCode = modelCode;
    }

    public String getImeiNo() {
        return imeiNo;
    }

    public void setImeiNo(String imeiNo) {
        this.imeiNo = imeiNo;
    }

    public String getImeiStatusCode() {
        return imeiStatusCode;
    }

    public void setImeiStatusCode(String imeiStatusCode) {
        this.imeiStatusCode = imeiStatusCode;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public String getOperateType() {
        return operateType;
    }

    public void setOperateType(String operateType) {
        this.operateType = operateType;
    }

    public Integer getStockInItemId() {
        return stockInItemId;
    }

    public void setStockInItemId(Integer stockInItemId) {
        this.stockInItemId = stockInItemId;
    }

    public Integer getStockOutItemId() {
        return stockOutItemId;
    }

    public void setStockOutItemId(Integer stockOutItemId) {
        this.stockOutItemId = stockOutItemId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

}