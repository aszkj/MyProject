package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 数据包产品实体类，关联产品域表YiLiDiProductCenter.P_PACKET_PRODUCT
 * 
 * @author: chenlian
 * @date: 2016年12月9日 下午6:26:21
 */
public class AuditProduct extends BaseModel {

    private static final long serialVersionUID = 1903267708542171150L;
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 批次号
     */
    private String batchNo;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 品牌编码，关联产品域产品品牌表P_PRODUCT_BRAND的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 普通会员售价，单位厘
     */
    private Long retailPrice;
    /**
     * VIP会员售价，单位厘
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
    /**
     * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
     */
    private String channelCode;
    /**
     * 产品规格
     */
    private String productSpec;
    /**
     * 详情内容
     */
    private String content;
    /**
     * 显示顺序
     */
    private Integer displayOrder;
    /**
     * 提交审核时间
     */
    private Date submitTime;
    /**
     * 审核状态 关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PACKETPRODUCTAUDITSTATUS)
     */
    private String auditStatus;
    /**
     * 初审用户ID
     */
    private Integer initAuditUserId;
    /**
     * 初审时间
     */
    private Date initAuditTime;
    /**
     * 初审不通过理由
     */
    private String initAuditRejectReason;
    /**
     * 终审用户ID
     */
    private Integer finalAuditUserId;
    /**
     * 终审时间
     */
    private Date finalAuditTime;
    /**
     * 终审不通过理由
     */
    private String finalAuditRejectReason;
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
     * 数据来源
     */
    private String dataResource;
    
    
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

	public String getDataResource() {
		return dataResource;
	}

	public void setDataResource(String dataResource) {
		this.dataResource = dataResource;
	}
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
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

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getProductSpec() {
        return productSpec;
    }

    public void setProductSpec(String productSpec) {
        this.productSpec = productSpec;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
    }

    public Integer getInitAuditUserId() {
        return initAuditUserId;
    }

    public void setInitAuditUserId(Integer initAuditUserId) {
        this.initAuditUserId = initAuditUserId;
    }

    public Date getInitAuditTime() {
        return initAuditTime;
    }

    public void setInitAuditTime(Date initAuditTime) {
        this.initAuditTime = initAuditTime;
    }

    public String getInitAuditRejectReason() {
        return initAuditRejectReason;
    }

    public void setInitAuditRejectReason(String initAuditRejectReason) {
        this.initAuditRejectReason = initAuditRejectReason;
    }

    public Integer getFinalAuditUserId() {
        return finalAuditUserId;
    }

    public void setFinalAuditUserId(Integer finalAuditUserId) {
        this.finalAuditUserId = finalAuditUserId;
    }

    public Date getFinalAuditTime() {
        return finalAuditTime;
    }

    public void setFinalAuditTime(Date finalAuditTime) {
        this.finalAuditTime = finalAuditTime;
    }

    public String getFinalAuditRejectReason() {
        return finalAuditRejectReason;
    }

    public void setFinalAuditRejectReason(String finalAuditRejectReason) {
        this.finalAuditRejectReason = finalAuditRejectReason;
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

}