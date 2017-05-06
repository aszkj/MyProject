/**
 * 文件名称：ProductDto.java
 * 
 * 描述：产品模型Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：产品模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductDto extends BaseDto {
    private static final long serialVersionUID = 9017555742436790314L;
    private static final String DEFAULT_STATUSCODE = "PRODUCTSTATUS_ON";
//    private static final String DEFAULT_BRANDCODE = "XX";

    public ProductDto() {
        this.statusCode = DEFAULT_STATUSCODE;
//        this.brandCode = DEFAULT_BRANDCODE;
    }

    /************
     * 导入标准库产品到商家需用到*************** /** 每次操作采购或者调拨的数量
     */
    private Integer perOperCount;
    /**
     * 产品ID
     */
    private Integer id;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 产品类别父类编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String parentCode;
    /**
     * 产品编码，关联产品域品牌表P_PRODUCT_BRAND的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 产品品牌名称
     */
    private String brandName;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 产品状态, 标识该产品是否有效，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSTATUS)
     */
    private String statusCode;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 将产品价格dto作为属性注入
     */
    private ProductPriceDto productPriceDto;
    /**
     * 将产品图片dto作为属性注入 *可能有多个图片
     */
    private List<ProductImageDto> productImageDtos;
    /**
     * 将产品描述信息dto作为属性注入
     */
    private ProductProfileDto productProfileDto;
    /**
     * 
     * @Description 传递产品的相关信息(页面需要显示的)
     * @return
     */

    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 产品类别父类名称
     */
    private String parentName;

    /**
     * 产品基础促销价，单位厘
     */
    private Long promotionalPrice;
    /**
     * 产品基础零售价，单位厘
     */
    private Long retailPrice;
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

    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 是否热卖
     * 
     */
    private String hotSaleFlag;
    /**
     * 是否热卖描述
     * 
     */
    private String hotSaleFlagName;
    /**
     * 上架状态, 标识该产品是否上架，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
     */
    private String saleStatus;
    /**
     * 上架状态描述（用于前台显示）
     */
    private String saleStatusName;

    /**
     * 产品显示顺序
     */
    private Integer displayOrder;
    /**
     * 产品规格
     */
    private String productSpec;

    /**
     * 产品加载时内容详情里的图片
     */
    private String loadContentImageUrls;
    /**
     * 产品保存时内容详情里的图片
     */
    private String addContentImageUrls;
    /**
     * 产品保存时内容详情里的值传递
     */
    private String contentString;

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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getSaleStatusName() {
        return saleStatusName;
    }

    public void setSaleStatusName(String saleStatusName) {
        this.saleStatusName = saleStatusName;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
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

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public ProductPriceDto getProductPriceDto() {
        return productPriceDto;
    }

    public void setProductPriceDto(ProductPriceDto productPriceDto) {
        this.productPriceDto = productPriceDto;
    }

    public List<ProductImageDto> getProductImageDtos() {
        return productImageDtos;
    }

    public void setProductImageDtos(List<ProductImageDto> productImageDtos) {
        this.productImageDtos = productImageDtos;
    }

    public ProductProfileDto getProductProfileDto() {
        return productProfileDto;
    }

    public void setProductProfileDto(ProductProfileDto productProfileDto) {
        this.productProfileDto = productProfileDto;
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

    public String getHotSaleFlagName() {
        return hotSaleFlagName;
    }

    public void setHotSaleFlagName(String hotSaleFlagName) {
        this.hotSaleFlagName = hotSaleFlagName;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public String getProductSpec() {
        return productSpec;
    }

    public void setProductSpec(String productSpec) {
        this.productSpec = productSpec;
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

    public Integer getPerOperCount() {
        return perOperCount;
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

    public void setPerOperCount(Integer perOperCount) {
        this.perOperCount = perOperCount;
    }
}