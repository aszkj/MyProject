package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：供应商物流设置实体类，映射用户域表YiLiDiUserCenter.U_LOGISTICS_SETTING <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class LogisticSetting extends BaseModel {
	private static final long serialVersionUID = 52245814641880675L;
	/**
	 * 设置ID， 自增主键
	 */
	private Integer id;
	/**
	 * 运营商ID
	 */
	private Integer operatorId;
	/**
	 * 物流ID，关联系统域系统字典中的物流定义
	 */
	private String logisticsCode;
	/**
	 * 计价方式："LOGISTFEETYPE_WEIGHT" 按重量， "LOGISTFEETYPE_COUNT" 按数量，默认"LOGISTFEETYPE_WEIGHT"
	 */
	private String feeType;
	/**
	 * 默认首量，即在该件或重量范围以内都按照默认的首费来进行收费。单位为件或克
	 */
	private Integer firstCount;
	/**
	 * 默认首费，默认的费用，单位为厘
	 */
	private Long firstFee;
	/**
	 * 默认增加量，单位为件或克，即如果是按重量收费，则是克，如果是按件收费，则是件
	 */
	private Integer addCount;
	/**
	 * 默认增加费，即在超过首重后，没增加多少千克增加的费用，单位厘
	 */
	private Long addFee;
	/**
	 * 免运费条件数量， 即订单中商品满多少件，可以免收运费
	 */
	private Integer freeQuantity;
	/**
	 * 免运费条件总额， 即订单满多少元时，可以免收运费， 单位厘
	 */
	private Long freeAmount;
	/**
	 * 有效状态： "LOGISTENABLEDFLAG_ON" 有效，"LOGISTENABLEDFLAG_OFF" 无效， 表示该供应商设置的哪个物流有效
	 */
	private String enabledFlag;
	/**
	 * 包邮设置： "LOGISTICS_FREESETTING_NONE" 不设置包邮条件， "LOGISTICS_FREESETTING_PURCHASE_PRICE" 按单次购买金额免费
	 * ，"LOGISTICS_FREESETTING_PURCHASE_COUNT" 按单次购买件数免费， "LOGISTICS_FREESETTING_PURCHASE_PRICE_AND_COUNT" 按单次购买金额和购买件数免费
	 */
	private String freeSetting;
	/**
	 * 创建用户ID
	 */
	private Integer createUserId;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 修改用户id
	 */
	private Integer modifyUserId;
	/**
	 * 修改时间
	 */
	private Date modifyTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOperatorId() {
		return operatorId;
	}

	public void setOperatorId(Integer operatorId) {
		this.operatorId = operatorId;
	}

	public String getLogisticsCode() {
		return logisticsCode;
	}

	public void setLogisticsCode(String logisticsCode) {
		this.logisticsCode = logisticsCode;
	}

	public String getFeeType() {
		return feeType;
	}

	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}

	public Integer getFirstCount() {
		return firstCount;
	}

	public void setFirstCount(Integer firstCount) {
		this.firstCount = firstCount;
	}

	public Long getFirstFee() {
		return firstFee;
	}

	public void setFirstFee(Long firstFee) {
		this.firstFee = firstFee;
	}

	public Integer getAddCount() {
		return addCount;
	}

	public void setAddCount(Integer addCount) {
		this.addCount = addCount;
	}

	public Long getAddFee() {
		return addFee;
	}

	public void setAddFee(Long addFee) {
		this.addFee = addFee;
	}

	public Integer getFreeQuantity() {
		return freeQuantity;
	}

	public void setFreeQuantity(Integer freeQuantity) {
		this.freeQuantity = freeQuantity;
	}

	public Long getFreeAmount() {
		return freeAmount;
	}

	public void setFreeAmount(Long freeAmount) {
		this.freeAmount = freeAmount;
	}

	public String getEnabledFlag() {
		return enabledFlag;
	}

	public void setEnabledFlag(String enabledFlag) {
		this.enabledFlag = enabledFlag;
	}

	public String getFreeSetting() {
		return freeSetting;
	}

	public void setFreeSetting(String freeSetting) {
		this.freeSetting = freeSetting;
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

}