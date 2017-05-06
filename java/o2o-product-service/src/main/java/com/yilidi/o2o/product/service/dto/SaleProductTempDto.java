/**
 * 文件名称：SaleProductProfileHistoryDto.java
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
 * 功能描述：临时商品实体类Dto<br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductTempDto extends BaseDto {

    private static final long serialVersionUID = 2309008398255864662L;

    /**
     * 店铺临时商品ID，自增主键
     */
    private Integer tempId;
    /**
     * 店铺ID, 关联客户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;
    /**
     * 商品ID， 关联产品域店铺商品信息表P_SALE_PRODUCT的ID字段',
     */
    private Integer saleProductId;
    /**
     * 商品ID, 关联商品域P_PRODUCT表的PRODUCTID字段
     */
    private Integer productId;
    /**
     * 商品类别编码，关联商品域商品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 商品类别父类编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String parentCode;
    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 产品类别父类名称
     */
    private String parentName;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 审核状态编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTAUDITSTATUS)
     */
    private String auditStatusCode;
    /**
     * 审核意见
     */
    private String auditNote;
    /**
     * 店铺商品基础促销价，单位分
     */
    private Long promotionalPrice;
    /**
     * 店铺商品基础零售价，单位厘
     */
    private Long retailPrice;
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 是否热卖
     */
    private String hotSaleFlag;
    /**
     * 商品上下架状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEPRODUCTSALESTATUS)
     */
    private String saleStatus;
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
     * 修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;

    /**
     * 将商品图片dto作为属性注入 *可能有多个图片
     */
    private List<SaleProductImageTempDto> saleProductImageTempDtos;

    /************
     * 传递图片参数专用***************
     * 
     * /** app端第几张是主图
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
     * 销售佣金结算金额，单位为厘，默认0
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

    public List<SaleProductImageTempDto> getSaleProductImageTempDtos() {
        return saleProductImageTempDtos;
    }

    public void setSaleProductImageTempDtos(List<SaleProductImageTempDto> saleProductImageTempDtos) {
        this.saleProductImageTempDtos = saleProductImageTempDtos;
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

    public Integer getTempId() {
        return tempId;
    }

    public void setTempId(Integer tempId) {
        this.tempId = tempId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
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

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getAuditStatusCode() {
        return auditStatusCode;
    }

    public void setAuditStatusCode(String auditStatusCode) {
        this.auditStatusCode = auditStatusCode;
    }

    public String getAuditNote() {
        return auditNote;
    }

    public void setAuditNote(String auditNote) {
        this.auditNote = auditNote;
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

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
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

}