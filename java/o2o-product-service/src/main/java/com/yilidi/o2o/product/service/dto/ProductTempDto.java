/**
 * 文件名称：ProductTempDto.java
 * 
 * 描述：临时产品模型Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：临时产品实体类Dto，关联产品域表YiLiDiProductCenter.P_PRODUCT_TEMP <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductTempDto extends BaseDto {
    private static final long serialVersionUID = -8884679954698177762L;
    /**
     * 产品ID
     */
    private Integer tempId;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 产品父类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String parentCode;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 产品基础零售价，单位厘
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
     * 是否热卖态描述（仅供前台显示用）
     */
    private String hotSaleFlagName;
    /**
     * 上架状态, 标识该产品是否上架，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
     */
    private String saleStatus;
    /**
     * 产品状态描述（仅供前台显示用）
     */
    private String saleStatusName;
    /**
     * 产品规格
     */
    private String productSpec;
    /**
     * 显示顺序
     */
    private Integer displayOrder;

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

    public Integer getTempId() {
        return tempId;
    }

    public void setTempId(Integer tempId) {
        this.tempId = tempId;
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

    public String getProductSpec() {
        return productSpec;
    }

    public void setProductSpec(String productSpec) {
        this.productSpec = productSpec;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
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

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
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