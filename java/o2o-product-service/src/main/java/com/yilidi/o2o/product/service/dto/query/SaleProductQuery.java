/**
 * 文件名称：SaleProductQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：商品查询条件封装类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductQuery extends BaseQuery {
    private static final long serialVersionUID = 8295697720955038354L;
    /**
     * 商品ID
     */
    private Integer id;
    /**
     * 店铺ID, 关联客户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;
    /**
     * 店铺ID列表
     */
    private List<Integer> storeIds;
    /**
     * 店铺编码
     */
    private String storeCode;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 店铺类型
     */
    private String storeType;
    /**
     * 产品ID, 关联产品域P_PRODUCT表的PRODUCTID字段
     */
    private Integer productId;
    /**
     * 产品类别父类编码(目前只有两级分类)，关联产品域产品分类表P_PRODUCT_CLASS的PARENTCODE字段
     */
    private String parentCode;
    /**
     * 商品类别编码，关联商品域商品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 商品分类是否显示
     */
    private String display;
    /**
     * 商品类别列表
     */
    private List<String> productClassCodes;
    /**
     * 商品编码，关联商品域品牌表P_PRODUCT_BRAND的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 品牌code列表
     */
    private List<String> brandCodes;

    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 商品来源
     */
    private String saleProductSource;
    /**
     * 商品条形码，商品的唯一标识
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
     * 产品状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTSALESTATUS)
     */
    private String saleStatus;
    /**
     * 是否有效商品标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTENABLEDFLAG)。该字段对用户操作不可见，当该商品引用的商品被设置为禁用时，该字段需要更新为“
     * SALEPRODUCTENABLEDFLAG_OFF” 无效状态。当商品设置为启用状态是，该字段更新为"SALEPRODUCTENABLEDFLAG_ON"有效状态。默认为"SALEPRODUCTENABLEDFLAG_ON"
     */
    private String enabledFlag;
    /**
     * 审核用户ID
     */
    private Integer auditUserId;
    /**
     * 审核开始时间
     */
    private Date startAuditTime;
    /**
     * 审核结束时间
     */
    private Date endAuditTime;
    /**
     * 审核意见
     */
    private String auditNote;
    /**
     * 查询创建用户ID
     */
    private Integer createUserId;
    /**
     * 查询创建开始时间
     */
    private Date startCreateTime;
    /**
     * 查询创建结束时间
     */
    private Date endCreateTime;
    /**
     * 查询修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 查询修改开始时间
     */
    private Date startModifyTime;
    /**
     * 查询修改结束时间
     */
    private Date endModifyTime;
    /**
     * 商品查询促销价最大值，单位厘
     */
    private Long promotionalMaxPrice;
    /**
     * 商品查询促销价最小值，单位厘
     */
    private Long promotionalMinPrice;
    /**
     * 商品查询零售价最大范围值，单位厘
     */
    private Long retailMaxPrice;
    /**
     * 商品查询零售价最小范围值，单位厘
     */
    private Long retailMinPrice;
    /**
     * 卖点描述
     */
    private String sellPoint;
    /**
     * 产品归属
     */
    private String productOwner;
    /**
     * 是否热卖
     */
    private String hotSaleFlag;
    /**
     * 详情内容
     */
    private String content;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 显示顺序
     */
    private Integer displayOrder;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 商品搜索关键字
     */
    private String keywords;

    /**
     * 小区ID
     */
    private Integer communityId;
    /** 销售专区类型编码 **/
    private String typeCode;

    /**
     * 楼层ID
     */
    private Integer floorId;

    /**
     * 商品分类数组
     */
    private List<Object> classCodes;

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

    public List<Integer> getStoreIds() {
        return storeIds;
    }

    public void setStoreIds(List<Integer> storeIds) {
        this.storeIds = storeIds;
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

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public List<String> getBrandCodes() {
        return brandCodes;
    }

    public void setBrandCodes(List<String> brandCodes) {
        this.brandCodes = brandCodes;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getSaleProductSource() {
        return saleProductSource;
    }

    public void setSaleProductSource(String saleProductSource) {
        this.saleProductSource = saleProductSource;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
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

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
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

    public Date getStartAuditTime() {
        return startAuditTime;
    }

    public void setStartAuditTime(Date startAuditTime) {
        this.startAuditTime = startAuditTime;
    }

    public Date getEndAuditTime() {
        return endAuditTime;
    }

    public void setEndAuditTime(Date endAuditTime) {
        this.endAuditTime = endAuditTime;
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

    public Date getStartCreateTime() {
        return startCreateTime;
    }

    public void setStartCreateTime(Date startCreateTime) {
        this.startCreateTime = startCreateTime;
    }

    public Date getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(Date endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getStartModifyTime() {
        return startModifyTime;
    }

    public void setStartModifyTime(Date startModifyTime) {
        this.startModifyTime = startModifyTime;
    }

    public Date getEndModifyTime() {
        return endModifyTime;
    }

    public void setEndModifyTime(Date endModifyTime) {
        this.endModifyTime = endModifyTime;
    }

    public Long getPromotionalMaxPrice() {
        return promotionalMaxPrice;
    }

    public void setPromotionalMaxPrice(Long promotionalMaxPrice) {
        this.promotionalMaxPrice = promotionalMaxPrice;
    }

    public Long getPromotionalMinPrice() {
        return promotionalMinPrice;
    }

    public void setPromotionalMinPrice(Long promotionalMinPrice) {
        this.promotionalMinPrice = promotionalMinPrice;
    }

    public Long getRetailMaxPrice() {
        return retailMaxPrice;
    }

    public void setRetailMaxPrice(Long retailMaxPrice) {
        this.retailMaxPrice = retailMaxPrice;
    }

    public Long getRetailMinPrice() {
        return retailMinPrice;
    }

    public void setRetailMinPrice(Long retailMinPrice) {
        this.retailMinPrice = retailMinPrice;
    }

    public String getSellPoint() {
        return sellPoint;
    }

    public void setSellPoint(String sellPoint) {
        this.sellPoint = sellPoint;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public List<String> getProductClassCodes() {
        return productClassCodes;
    }

    public void setProductClassCodes(List<String> productClassCodes) {
        this.productClassCodes = productClassCodes;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public List<Object> getClassCodes() {
        return classCodes;
    }

    public void setClassCodes(List<Object> classCodes) {
        this.classCodes = classCodes;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

}
