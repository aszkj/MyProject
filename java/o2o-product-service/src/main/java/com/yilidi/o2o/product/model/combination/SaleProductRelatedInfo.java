/**
 * 文件名称：SaleProductRelatedInfo.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.product.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：将产品相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductRelatedInfo extends BaseModel {
    private static final long serialVersionUID = -5818403015244900714L;

    /**
     * **********************商品基础信息***************************** /** /** 商品ID，自增主键
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
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 是否有效商品标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTENABLEDFLAG)。该字段对用户操作不可见，当该商品引用的商品被设置为禁用时，该字段需要更新为“
     * SALEPRODUCTENABLEDFLAG_OFF” 无效状态。当商品设置为启用状态是，该字段更新为"SALEPRODUCTENABLEDFLAG_ON"有效状态。默认为"SALEPRODUCTENABLEDFLAG_ON"
     */
    private String enabledFlag;
    /**
     * 审核状态
     */
    private String auditStatusCode;
    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 产品类别父类名称
     */
    private String parentName;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 每次操作采购或者调拨的数量
     */
    private Integer perOperCount;

    /**
     * **********************商品价格信息***************************** /**
     * 
     * /** 店铺商品基础促销价，单位厘
     */
    private Long promotionalPrice;
    /**
     * 店铺商品基础零售价，单位厘
     */
    private Long retailPrice;
    /**
     * 商品佣金
     */
    private Long commissionPrice;
    /**
     * **********************商品附加信息***************************** /**
     * 
     * /** 产品归属
     */
    private String productOwner;
    /**
     * 是否热卖
     */
    private String hotSaleFlag;
    /**
     * 商品状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTSALESTATUS)
     */
    private String saleStatus;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 商品来源
     */
    private String saleProductSource;
    /**
     * 商品显示顺序
     */
    private Integer displayOrder;
    /**
     * 商品详情
     */
    private String content;

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
     * 库存
     */
    private Integer remainCount;
    /**
     * 销量
     */
    private Integer saleCount;
    /**
     * 品牌编码
     */
    private String brandCode;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 进货成本金额，单位为厘，默认0
     */
    private Long costPrice;
    /**
     * VIP销售佣金结算金额，单位为厘，默认0
     */
    private Long vipCommissionPrice;

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

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
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

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(String enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

    public String getAuditStatusCode() {
        return auditStatusCode;
    }

    public void setAuditStatusCode(String auditStatusCode) {
        this.auditStatusCode = auditStatusCode;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public String getProductOwner() {
        return productOwner;
    }

    public void setProductOwner(String productOwner) {
        this.productOwner = productOwner;
    }

    public String getHotSaleFlag() {
        return hotSaleFlag;
    }

    public void setHotSaleFlag(String hotSaleFlag) {
        this.hotSaleFlag = hotSaleFlag;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public String getSaleProductSource() {
        return saleProductSource;
    }

    public void setSaleProductSource(String saleProductSource) {
        this.saleProductSource = saleProductSource;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
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

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(Integer saleCount) {
        this.saleCount = saleCount;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Integer getPerOperCount() {
        return perOperCount;
    }

    public void setPerOperCount(Integer perOperCount) {
        this.perOperCount = perOperCount;
    }

    public Long getCommissionPrice() {
        return commissionPrice;
    }

    public void setCommissionPrice(Long commissionPrice) {
        this.commissionPrice = commissionPrice;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Long getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Long costPrice) {
        this.costPrice = costPrice;
    }

    public Long getVipCommissionPrice() {
        return vipCommissionPrice;
    }

    public void setVipCommissionPrice(Long vipCommissionPrice) {
        this.vipCommissionPrice = vipCommissionPrice;
    }

}