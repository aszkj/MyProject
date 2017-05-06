package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 数据包产品DTO
 * 
 * @author: chenlian
 * @date: 2016年12月9日 下午6:52:06
 */
public class AuditProductDto extends BaseDto {

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
     * 产品类别编码
     */
    private String productClassCode;
    /**
     * 产品类别名称
     */
    private String productClassName;
    /**
     * 品牌编码
     */
    private String brandCode;
    /**
     * 品牌名称
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
     * 渠道编码
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
     * 审核状态
     */
    private String auditStatus;
    /**
     * 审核状态名称
     */
    private String auditStatusName;
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
     * 产品图片URL列表
     */
    private List<String> productImageUrls;
    /**
     * 产品图片DTO列表
     */
    private List<AuditProductImageDto> productImageDtos;
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
    private AuditProductImageProfileDto firstAppImageProfileDto;
    /**
     * app端第二张图片Dto
     */
    private AuditProductImageProfileDto secondAppImageProfileDto;
    /**
     * app端第三张图片Dto
     */
    private AuditProductImageProfileDto thirdAppImageProfileDto;
    /**
     * app端第四张图片Dto
     */
    private AuditProductImageProfileDto fouthAppImageProfileDto;
    /**
     * app端第五张图片Dto
     */
    private AuditProductImageProfileDto fiveAppImageProfileDto;
    /**
     * app端第六张图片Dto
     */
    private AuditProductImageProfileDto sixAppImageProfileDto;
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

    public String getProductClassName() {
        return productClassName;
    }

    public void setProductClassName(String productClassName) {
        this.productClassName = productClassName;
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

    public String getAuditStatusName() {
        return auditStatusName;
    }

    public void setAuditStatusName(String auditStatusName) {
        this.auditStatusName = auditStatusName;
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

    public List<String> getProductImageUrls() {
        return productImageUrls;
    }

    public void setProductImageUrls(List<String> productImageUrls) {
        this.productImageUrls = productImageUrls;
    }

    public List<AuditProductImageDto> getProductImageDtos() {
        return productImageDtos;
    }

    public void setProductImageDtos(List<AuditProductImageDto> productImageDtos) {
        this.productImageDtos = productImageDtos;
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

    public AuditProductImageProfileDto getFirstAppImageProfileDto() {
        return firstAppImageProfileDto;
    }

    public void setFirstAppImageProfileDto(AuditProductImageProfileDto firstAppImageProfileDto) {
        this.firstAppImageProfileDto = firstAppImageProfileDto;
    }

    public AuditProductImageProfileDto getSecondAppImageProfileDto() {
        return secondAppImageProfileDto;
    }

    public void setSecondAppImageProfileDto(AuditProductImageProfileDto secondAppImageProfileDto) {
        this.secondAppImageProfileDto = secondAppImageProfileDto;
    }

    public AuditProductImageProfileDto getThirdAppImageProfileDto() {
        return thirdAppImageProfileDto;
    }

    public void setThirdAppImageProfileDto(AuditProductImageProfileDto thirdAppImageProfileDto) {
        this.thirdAppImageProfileDto = thirdAppImageProfileDto;
    }

    public AuditProductImageProfileDto getFouthAppImageProfileDto() {
        return fouthAppImageProfileDto;
    }

    public void setFouthAppImageProfileDto(AuditProductImageProfileDto fouthAppImageProfileDto) {
        this.fouthAppImageProfileDto = fouthAppImageProfileDto;
    }

    public AuditProductImageProfileDto getFiveAppImageProfileDto() {
        return fiveAppImageProfileDto;
    }

    public void setFiveAppImageProfileDto(AuditProductImageProfileDto fiveAppImageProfileDto) {
        this.fiveAppImageProfileDto = fiveAppImageProfileDto;
    }

    public AuditProductImageProfileDto getSixAppImageProfileDto() {
        return sixAppImageProfileDto;
    }

    public void setSixAppImageProfileDto(AuditProductImageProfileDto sixAppImageProfileDto) {
        this.sixAppImageProfileDto = sixAppImageProfileDto;
    }

}