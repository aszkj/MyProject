package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：订单佣金结算记录实体类，映射交易域表YiLiDiOrderCenter.T_COMMISSION_CLEARUP <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CommissionClearup extends BaseModel {
	private static final long serialVersionUID = 962070828844234568L;
	/**
	 * 记录编号，主键
	 */
	private Integer id;
	/**
	 * 订单编号
	 */
	private String saleOrderNo;
	/**
	 * 店铺ID
	 */
	private Integer storeId;
	/**
	 * 总价钱, 每款产品数量*产品单价 的总和，单位 厘
	 */
	private Long totalAmount;
	/**
	 * 总运费，单位 厘
	 */
	private Long transferFee;
	/**
	 * 付款时间
	 */
	private Date payTime;
	/**
	 * 订单创建时间
	 */
	private Date createTime;
	/**
	 * 结算金额，单位 厘
	 */
	private Long clearAmount;
    /**
     * 结算方式，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONCLEARTYPE)
     */
    private String clearType;
    /**
     * 结算方式，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONCLEARUPOPERTYPE)
     */
    private String clearOperType;
	/**
	 * 结算标志，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COMMISSIONCLEARUPSTATUS)
	 */
	private String statusCode;
	/**
	 * 结算时间
	 */
	private Date clearTime;
	/**
	 * 结算操作人
	 */
	private Integer clearUserId;

	/**
	 * 获取id
	 * 
	 * @return id
	 */
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSaleOrderNo() {
		return saleOrderNo;
	}

	public void setSaleOrderNo(String saleOrderNo) {
		this.saleOrderNo = saleOrderNo;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

	public Long getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(Long totalAmount) {
		this.totalAmount = totalAmount;
	}

	public Long getTransferFee() {
		return transferFee;
	}

	public void setTransferFee(Long transferFee) {
		this.transferFee = transferFee;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getClearAmount() {
		return clearAmount;
	}

	public void setClearAmount(Long clearAmount) {
		this.clearAmount = clearAmount;
	}

	public String getClearType() {
        return clearType;
    }

    public void setClearType(String clearType) {
        this.clearType = clearType;
    }

    public String getClearOperType() {
        return clearOperType;
    }

    public void setClearOperType(String clearOperType) {
        this.clearOperType = clearOperType;
    }

    public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public Date getClearTime() {
		return clearTime;
	}

	public void setClearTime(Date clearTime) {
		this.clearTime = clearTime;
	}

	public Integer getClearUserId() {
		return clearUserId;
	}

	public void setClearUserId(Integer clearUserId) {
		this.clearUserId = clearUserId;
	}
}