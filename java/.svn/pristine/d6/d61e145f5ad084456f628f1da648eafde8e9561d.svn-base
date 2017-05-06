package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品历史记录实体类，映射产品域表 YiLiDiProductCenter.P_SALE_PRODUCT_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductHistory extends BaseModel {

    private static final long serialVersionUID = -7453293955492739853L;

    /**
     * ID, 自增主键
     */
    private Integer id;

    /**
     * 店铺商品ID
     */
    private Integer saleProductId;

    /**
     * 店铺ID, 关联客户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;

    /**
     * 产品ID, 关联产品域P_PRODUCT表的PRODUCTID字段
     */
    private Integer productId;

    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;

    /**
     * 品牌编码, 关联产品域P_PRODUCT_BRAND表的BRANDCODE字段
     */
    private String brandCode;

    /**
     * 商品名称
     */
    private String saleProductName;

    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 上市时间
     */
    private Date marketTime;

    /**
     * 审核状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTAUDITSTATUS)
     */
    private String auditStatusCode;

    /**
     * 是否有效商品标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTENABLEDFLAG)。该字段对用户操作不可见，当该商品引用的产品被设置为禁用时，该字段需要更新为“
     * SALEPRODUCTENABLEDFLAG_OFF” 无效状态。当产品设置为启用状态是，该字段更新为"SALEPRODUCTENABLEDFLAG_ON"有效状态。默认为"SALEPRODUCTENABLEDFLAG_ON"
     */
    private String enabledFlag;
    /**
     * 审核用户ID
     */
    private Integer auditUserId;
    /**
     * 审核时间
     */
    private Date auditTime;
    /**
     * 审核意见
     */
    private String auditNote;
    /**
     * 操作用户id
     */
    private Integer operateUserId;

    /**
     * 操作时间
     */
    private Date operateTime;

    /**
     * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTOPERTYPE)
     */
    private String operateType;

    /**
     * 操作描述
     */
    private String operateDesc;
    /**
     * 每次操作采购或者调拨的数量
     */
    private Integer perOperCount;

    public SaleProductHistory() {
        this.perOperCount = 1;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
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

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public Date getMarketTime() {
        return marketTime;
    }

    public void setMarketTime(Date marketTime) {
        this.marketTime = marketTime;
    }

    public String getAuditStatusCode() {
        return auditStatusCode;
    }

    public void setAuditStatusCode(String auditStatusCode) {
        this.auditStatusCode = auditStatusCode;
    }

    public String getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(String enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

    public Integer getAuditUserId() {
        return auditUserId;
    }

    public void setAuditUserId(Integer auditUserId) {
        this.auditUserId = auditUserId;
    }

    public Date getAuditTime() {
        return auditTime;
    }

    public void setAuditTime(Date auditTime) {
        this.auditTime = auditTime;
    }

    public String getAuditNote() {
        return auditNote;
    }

    public void setAuditNote(String auditNote) {
        this.auditNote = auditNote;
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

    public String getOperateDesc() {
        return operateDesc;
    }

    public void setOperateDesc(String operateDesc) {
        this.operateDesc = operateDesc;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public Integer getPerOperCount() {
        return perOperCount;
    }

    public void setPerOperCount(Integer perOperCount) {
        this.perOperCount = perOperCount;
    }

}