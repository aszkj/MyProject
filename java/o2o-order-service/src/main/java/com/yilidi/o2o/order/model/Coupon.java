package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 优惠券信息表，映射交易域表YiLiDiOrderCenter.T_COUPON
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午5:53:42
 */
public class Coupon extends BaseModel {

    private static final long serialVersionUID = -7232227312868193568L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 优惠券包ID
     */
    private Integer conPackId;
    /**
     * 优惠券发放批次号
     */
    private String batchNo;
    /**
     * 阶段编号
     */
    private Integer stageNo;

    /**
     * 使用范围编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COUPONSUSERANGE)
     */
    private String useRangeCode;

    /**
     * 使用范围，全场的时候为空，商品品类关联产品域P_PRODUCT_CLASS表的PRODUCTCLASSCODE字段以逗号相连，产品标示关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=
     * PRODUCTLABEL)以逗号相连，单个产品记录的是产品ID
     */
    private String useRange;
    /**
     * 优惠券有效期类型（）
     */
    private String validType;
    /**
     * 优惠券有效类型值
     */
    private String validTypeValue;
    /**
     * 发放范围编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COUPONSGRANTRANGE)
     */
    private String grantRange;

    /**
     * 发放方式编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COUPONSGRANTWAY)
     */
    private String grantWay;

    /**
     * 客户类型编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)',
     */
    private String customerType;

    /**
     * 买家用户类型标示编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=BUYERUSERTYPELABEL)
     */
    private String buyerUserType;

    /**
     * 卖家用户类型标示编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SELLERUSERTYPELABEL)
     */
    private String sellerUserType;

    /**
     * 发放时间
     */
    private Date grantTime;

    /**
     * 发放人
     */
    private Integer grantUserId;

    /**
     * 使用规格说明
     */
    private String rule;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getConPackId() {
        return conPackId;
    }

    public void setConPackId(Integer conPackId) {
        this.conPackId = conPackId;
    }

    public String getUseRangeCode() {
        return useRangeCode;
    }

    public void setUseRangeCode(String useRangeCode) {
        this.useRangeCode = useRangeCode;
    }

    public String getUseRange() {
        return useRange;
    }

    public void setUseRange(String useRange) {
        this.useRange = useRange;
    }

    public String getGrantRange() {
        return grantRange;
    }

    public void setGrantRange(String grantRange) {
        this.grantRange = grantRange;
    }

    public String getGrantWay() {
        return grantWay;
    }

    public void setGrantWay(String grantWay) {
        this.grantWay = grantWay;
    }

    public String getCustomerType() {
        return customerType;
    }

    public void setCustomerType(String customerType) {
        this.customerType = customerType;
    }

    public String getBuyerUserType() {
        return buyerUserType;
    }

    public void setBuyerUserType(String buyerUserType) {
        this.buyerUserType = buyerUserType;
    }

    public String getSellerUserType() {
        return sellerUserType;
    }

    public void setSellerUserType(String sellerUserType) {
        this.sellerUserType = sellerUserType;
    }

    public Date getGrantTime() {
        return grantTime;
    }

    public void setGrantTime(Date grantTime) {
        this.grantTime = grantTime;
    }

    public Integer getGrantUserId() {
        return grantUserId;
    }

    public void setGrantUserId(Integer grantUserId) {
        this.grantUserId = grantUserId;
    }

    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public String getValidType() {
		return validType;
	}

	public void setValidType(String validType) {
		this.validType = validType;
	}

	public String getValidTypeValue() {
		return validTypeValue;
	}

	public void setValidTypeValue(String validTypeValue) {
		this.validTypeValue = validTypeValue;
	}

	public Integer getStageNo() {
		return stageNo;
	}

	public void setStageNo(Integer stageNo) {
		this.stageNo = stageNo;
	}

}
