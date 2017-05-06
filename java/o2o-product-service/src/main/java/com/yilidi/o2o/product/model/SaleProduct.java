package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：商品实体类，映射商品域表YiLiDiProductCenter.P_SALE_PRODUCT <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProduct extends BaseModel {
    private static final long serialVersionUID = 6092685665886995428L;

    private static final String DEFAULT_ENABLEDFLAG = "SALEPRODUCTENABLEDFLAG_ON";

    /**
     * 商品ID，自增主键
     */
    private Integer id;
    /**
     * 店铺ID, 关联客户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;
    /**
     * 店铺类型
     */
    private String storeType;
    /**
     * 商品ID, 关联商品域P_PRODUCT表的PRODUCTID字段
     */
    private Integer productId;
    /**
     * 商品类别编码，关联商品域商品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 品牌编码, 关联商品域P_PRODUCT_BRAND表的BRANDCODE字段
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
     * 是否有效商品标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTENABLEDFLAG)。该字段对用户操作不可见，当该商品引用的商品被设置为禁用时，该字段需要更新为“
     * SALEPRODUCTENABLEDFLAG_OFF” 无效状态。当商品设置为启用状态是，该字段更新为"SALEPRODUCTENABLEDFLAG_ON"有效状态。默认为"SALEPRODUCTENABLEDFLAG_ON"
     */
    private String enabledFlag = DEFAULT_ENABLEDFLAG;
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
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer modifyUserId;
    /**
     * 创建时间
     */
    private Date modifyTime;
    /**
     * 每次操作采购或者调拨的数量
     */
    private Integer perOperCount = 1;
    /**
     * 商品库存冗余字段,只用于查询排序
     */
    private Integer remainCount;

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

    public Integer getProductId() {
        return productId;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
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

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
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

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

}