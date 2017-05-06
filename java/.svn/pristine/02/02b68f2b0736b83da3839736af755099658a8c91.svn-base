/**
 * 文件名称：SaleProductDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品模型Dto <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductDto extends BaseDto {

    private static final long serialVersionUID = 8984182859024570609L;
    private static final String DEFAULT_ENABLEDFLAG = "SALEPRODUCTENABLEDFLAG_ON";
//    private static final String DEFAULT_BRANDCODE = "XX";

    public SaleProductDto() {
        this.enabledFlag = DEFAULT_ENABLEDFLAG;
//        this.brandCode = DEFAULT_BRANDCODE;
    }

    /**
     * 商品ID，自增主键
     */
    private Integer id;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺类型
     */
    private String storeType;
    /**
     * 商品ID
     */
    private Integer productId;
    /**
     * 商品类别编码
     */
    private String productClassCode;
    /**
     * 商品类别父类编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String parentCode;
    /**
     * 品牌编码
     */
    private String brandCode;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 上市时间
     */
    private Date marketTime;
    /**
     * 商品条形码，商品的唯一标识
     */
    private String barCode;
    /**
     * 审核状态编码
     */
    private String auditStatusCode;
    /**
     * 否有效商品标志
     */
    private String enabledFlag;
    /**
     * 否有效商品描述（仅供前台显示用）
     */
    private String enabledFlagName;
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

    // 商品附加属性****************************************
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
     * 是否热卖描述（仅供前台显示用）
     */
    private String hotSaleFlagName;
    /**
     * 商品上下架状态
     */
    private String saleStatus;
    /**
     * 商品上下架状态描述（仅供前台显示用）
     */
    private String saleStatusName;
    /**
     * 详情内容
     */
    private String content;
    /**
     * 商品来源
     */
    private String saleProductSource;
    /**
     * 商品来源描述（仅供前台显示用）
     */
    private String saleProductSourceName;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 显示顺序
     */
    private Integer displayOrder;

    // 商品价格***************************************************
    /**
     * 店铺商品基础促销价，单位厘
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
     * 进货成本金额，单位为厘，默认0
     */
    private Long costPrice;
    /**
     * VIP销售佣金结算金额，单位为厘，默认0
     */
    private Long vipCommissionPrice;
    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 产品类别父类名称
     */
    private String parentName;

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
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 将商品价格dto作为属性注入
     */
    private SaleProductPriceDto saleProductPriceDto;
    /**
     * 将商品附加信息dto作为属性注入
     */
    private SaleProductProfileDto saleProductProfileDto;
    /**
     * 将商品图片dto作为属性注入 *可能有多个图片
     */
    private List<SaleProductImageDto> saleProductImageDtos;

    /************
     * 传递图片参数专用***************
     * 
     */
    /**
     * 商品加载时内容详情里的图片
     */
    private String loadContentImageUrls;
    /**
     * 商品保存时内容详情里的图片
     */
    private String addContentImageUrls;
    /**
     * 商品保存时内容详情里的值传递
     */
    private String contentString;
    /**
     * app端第几张是主图
     */
    private Integer appIsMainPic;
    /**
     * app端需要删除的图片url组
     */
    private String deleteImageUrls;
    /**
     * app端第一张图片Dto
     */
    private ProductImageProfileDto firstAppImageProfileDto;
    /**
     * app端第二张图片Dto
     */
    private ProductImageProfileDto secondAppImageProfileDto;
    /**
     * app端第三张图片Dto
     */
    private ProductImageProfileDto thirdAppImageProfileDto;
    /**
     * app端第四张图片Dto
     */
    private ProductImageProfileDto fouthAppImageProfileDto;
    /**
     * app端第五张图片Dto
     */
    private ProductImageProfileDto fiveAppImageProfileDto;
    /**
     * app端第六张图片Dto
     */
    private ProductImageProfileDto sixAppImageProfileDto;

    /**
     * 库存
     */
    private Integer remainCount;
    /**
     * 已订购数量
     */
    private Integer orderCount;
    /**
     * 销量
     */
    private Integer saleCount;
    /** 品牌名称 **/
    private String brandName;
    /**
     * 每次操作采购或者调拨的数量
     */
    private Integer perOperCount;
    /**
     * 商品是否允许存在该产品分类
     */
    private String isAllowedExistClassCode = "Y";
    /**
     * 商品类别列表
     */
    private List<String> productClassCodes;
    /**
     * 是否共享库存
     */
    private String isStockShare;

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

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
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

    public SaleProductPriceDto getSaleProductPriceDto() {
        return saleProductPriceDto;
    }

    public void setSaleProductPriceDto(SaleProductPriceDto saleProductPriceDto) {
        this.saleProductPriceDto = saleProductPriceDto;
    }

    public List<SaleProductImageDto> getSaleProductImageDtos() {
        return saleProductImageDtos;
    }

    public void setSaleProductImageDtos(List<SaleProductImageDto> saleProductImageDtos) {
        this.saleProductImageDtos = saleProductImageDtos;
    }

    public String getLoadContentImageUrls() {
        return loadContentImageUrls;
    }

    public void setLoadContentImageUrls(String loadContentImageUrls) {
        this.loadContentImageUrls = loadContentImageUrls;
    }

    public String getAddContentImageUrls() {
        return addContentImageUrls;
    }

    public void setAddContentImageUrls(String addContentImageUrls) {
        this.addContentImageUrls = addContentImageUrls;
    }

    public String getContentString() {
        return contentString;
    }

    public void setContentString(String contentString) {
        this.contentString = contentString;
    }

    public Integer getAppIsMainPic() {
        return appIsMainPic;
    }

    public void setAppIsMainPic(Integer appIsMainPic) {
        this.appIsMainPic = appIsMainPic;
    }

    public String getDeleteImageUrls() {
        return deleteImageUrls;
    }

    public void setDeleteImageUrls(String deleteImageUrls) {
        this.deleteImageUrls = deleteImageUrls;
    }

    public ProductImageProfileDto getFirstAppImageProfileDto() {
        return firstAppImageProfileDto;
    }

    public void setFirstAppImageProfileDto(ProductImageProfileDto firstAppImageProfileDto) {
        this.firstAppImageProfileDto = firstAppImageProfileDto;
    }

    public ProductImageProfileDto getSecondAppImageProfileDto() {
        return secondAppImageProfileDto;
    }

    public void setSecondAppImageProfileDto(ProductImageProfileDto secondAppImageProfileDto) {
        this.secondAppImageProfileDto = secondAppImageProfileDto;
    }

    public ProductImageProfileDto getThirdAppImageProfileDto() {
        return thirdAppImageProfileDto;
    }

    public void setThirdAppImageProfileDto(ProductImageProfileDto thirdAppImageProfileDto) {
        this.thirdAppImageProfileDto = thirdAppImageProfileDto;
    }

    public ProductImageProfileDto getFouthAppImageProfileDto() {
        return fouthAppImageProfileDto;
    }

    public void setFouthAppImageProfileDto(ProductImageProfileDto fouthAppImageProfileDto) {
        this.fouthAppImageProfileDto = fouthAppImageProfileDto;
    }

    public ProductImageProfileDto getFiveAppImageProfileDto() {
        return fiveAppImageProfileDto;
    }

    public void setFiveAppImageProfileDto(ProductImageProfileDto fiveAppImageProfileDto) {
        this.fiveAppImageProfileDto = fiveAppImageProfileDto;
    }

    public ProductImageProfileDto getSixAppImageProfileDto() {
        return sixAppImageProfileDto;
    }

    public void setSixAppImageProfileDto(ProductImageProfileDto sixAppImageProfileDto) {
        this.sixAppImageProfileDto = sixAppImageProfileDto;
    }

    public SaleProductProfileDto getSaleProductProfileDto() {
        return saleProductProfileDto;
    }

    public void setSaleProductProfileDto(SaleProductProfileDto saleProductProfileDto) {
        this.saleProductProfileDto = saleProductProfileDto;
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

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSaleProductSource() {
        return saleProductSource;
    }

    public void setSaleProductSource(String saleProductSource) {
        this.saleProductSource = saleProductSource;
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

    public String getEnabledFlagName() {
        return enabledFlagName;
    }

    public void setEnabledFlagName(String enabledFlagName) {
        this.enabledFlagName = enabledFlagName;
    }

    public String getHotSaleFlagName() {
        return hotSaleFlagName;
    }

    public void setHotSaleFlagName(String hotSaleFlagName) {
        this.hotSaleFlagName = hotSaleFlagName;
    }

    public String getSaleStatusName() {
        return saleStatusName;
    }

    public void setSaleStatusName(String saleStatusName) {
        this.saleStatusName = saleStatusName;
    }

    public String getSaleProductSourceName() {
        return saleProductSourceName;
    }

    public void setSaleProductSourceName(String saleProductSourceName) {
        this.saleProductSourceName = saleProductSourceName;
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

    public String getIsAllowedExistClassCode() {
        return isAllowedExistClassCode;
    }

    public void setIsAllowedExistClassCode(String isAllowedExistClassCode) {
        this.isAllowedExistClassCode = isAllowedExistClassCode;
    }

    public List<String> getProductClassCodes() {
        return productClassCodes;
    }

    public void setProductClassCodes(List<String> productClassCodes) {
        this.productClassCodes = productClassCodes;
    }

    public Integer getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(Integer orderCount) {
        this.orderCount = orderCount;
    }

    public String getIsStockShare() {
        return isStockShare;
    }

    public void setIsStockShare(String isStockShare) {
        this.isStockShare = isStockShare;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}
