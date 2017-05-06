/**
 * 文件名称：SaleProductHistoryDto.java
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
 * 功能描述：商品历史记录模型Dto <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductHistoryDto extends BaseDto {
	private static final long serialVersionUID = -6373172681258861005L;

	/**
	 * ID, 自增主键
	 */
	private Integer id;

	/**
	 * 店铺商品ID
	 */
	private Integer saleProductId;

	/**
	 * 店铺ID
	 */
	private Integer storeId;

	/**
	 * 产品ID
	 */
	private Integer productId;

	/**
	 * 产品类别编码
	 */
	private String productClassCode;

	/**
	 * 品牌编码
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
	 * 审核状态编码
	 */
	private String auditStatusCode;

	/**
	 * 产品状态
	 */
	private String saleStatus;

	/**
	 * 是否有效商品标志
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
	 * 操作类型
	 */
	private String operateType;

	/**
	 * 操作描述
	 */
	private String operateDesc;

	/**
	 * 渠道编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CHANNELTYPE)
	 */
	private String channelCode;

	/**
	 * 将商品历史价格dto作为属性注入
	 */
	private SaleProductPriceHistoryDto saleProductPriceHistoryDto;
	/**
	 * 将商品历史图片dto作为属性注入 *可能有多个图片
	 */
	private List<SaleProductImageHistoryDto> saleProductImageHistoryDtos;
	/**
	 * 将商品历史描述信息dto作为属性注入
	 */
	private SaleProductProfileHistoryDto saleProductProfileHistoryDto;
    /**
     * 每次操作采购或者调拨的数量
     */
    private Integer perOperCount;

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

	public SaleProductPriceHistoryDto getSaleProductPriceHistoryDto() {
		return saleProductPriceHistoryDto;
	}

	public void setSaleProductPriceHistoryDto(SaleProductPriceHistoryDto saleProductPriceHistoryDto) {
		this.saleProductPriceHistoryDto = saleProductPriceHistoryDto;
	}

	public List<SaleProductImageHistoryDto> getSaleProductImageHistoryDtos() {
		return saleProductImageHistoryDtos;
	}

	public void setSaleProductImageHistoryDtos(List<SaleProductImageHistoryDto> saleProductImageHistoryDtos) {
		this.saleProductImageHistoryDtos = saleProductImageHistoryDtos;
	}

	public SaleProductProfileHistoryDto getSaleProductProfileHistoryDto() {
		return saleProductProfileHistoryDto;
	}

	public void setSaleProductProfileHistoryDto(SaleProductProfileHistoryDto saleProductProfileHistoryDto) {
		this.saleProductProfileHistoryDto = saleProductProfileHistoryDto;
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

	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}

    public Integer getPerOperCount() {
        return perOperCount;
    }

    public void setPerOperCount(Integer perOperCount) {
        this.perOperCount = perOperCount;
    }

}