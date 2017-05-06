/**
 * 文件名称：SaleOrderQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：订单查询条件封装类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderQueryDto extends BaseQuery {
    private static final long serialVersionUID = 7681492515562233746L;

    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 订单用户ID
     */
    private Integer userId;
    /**
     * 接单用户id
     */
    private Integer acceptUserId;
    
    /**
     * 买家CUSTOMERID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_BUYER）
     */
    private Integer buyerCustomerId;
    /**
     * 店铺ID，关联用户域U_CUSTOMER表的CUSTOMERID字段（CUSTOMERTYPE=CUSTOMERTYPE_SELLER）
     */
    private Integer storeId;
    /**
     * 订单类型
     */
    private String typeCode;
    /**
     * 订单状态
     */
    private String statusCode;
    /**
     * 订单渠道
     */
    private String channelCode;
    /**
     * 订单支付方式
     */
    private String payTypeCode;
    /**
     * 下订单查询开始时间
     */
    private Date startOrderDate;
    /**
     * 下订单查询结束时间
     */
    private Date endOrderDate;
    /**
     * 发货查询开始时间
     */
    private Date startSendDate;
    /**
     * 发货查询结束时间
     */
    private Date endSendDate;
    /**
     * 收货查询开始时间
     */
    private Date startTakeDate;
    /**
     * 收货查询结束时间
     */
    private Date endTakeDate;
    /**
     * 省份编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String proviceCode;
    /**
     * 市编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String cityCode;
    /**
     * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String countyCode;
    /**
     * 取消订单类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CANCELTYPECODE)
     */
    private String cancelTypeCode;
    /**
     * 配送方式
     */
    private String deliveryMode;
    /**
     * 优惠券使用的金额
     */
    private Long preferentialAmt;
    /**
     * 使用的优惠券编号
     */
    private String conCode;
    /**
     * 订单取消原因，根据类型得到的原因，取消订单类型为“其它原因”时，该字段为客户填写内容
     */
    private String cancelReason;
    /**
     * 订单取消时间
     */
    private Date cancelTime;
    /**
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;

    /**
     * 支付查询开始时间
     */
    private Date startPayDate;
    /**
     * 支付查询结束时间
     */
    private Date endPayDate;

    /**
     * 会员账号
     */
    private String userName;

    /**
     * 订单编号列表
     */
    private List<String> saleOrderNos;
    /**
     * 订单状态列表
     */
    private List<String> statusCodes;

    /**
     * 收货人姓名
     */
    private String consigneeUserName;

    /**
     * 
     * 收货人联系方式
     */
    private String consigneePhoneNo;

    /**
     * 门店编号
     */
    private String storeCode;

    /**
     * 查询下订单开始时间字符串
     */
    private String strBeginOrderTime;

    /**
     * 查询下订单结束时间字符串
     */
    private String strEndOrderTime;

    /**
     * 查询支付开始时间字符串
     */
    private String strBeginPriceTime;

    /**
     * 查询支付结束时间字符串
     */
    private String strEndPriceTime;

    /**
     * 昨天 今天 一周 一个月
     */
    private String dateType;
    /**
     * 订单是否已评价，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=APPRAISEFLAG)
     */
    private String appraiseFlag;

    /**
     * 开始时间字符串
     */
    private String strBeginTime;
    /**
     * 结束时间字符串
     */
    private String strEndTime;
    /**
     * 开始时间
     */
    private Date beginTime;
    /**
     * 结束时间
     */
    private Date endTime;

    
    public String getAppraiseFlag() {
        return appraiseFlag;
    }

    public void setAppraiseFlag(String appraiseFlag) {
        this.appraiseFlag = appraiseFlag;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getPayTypeCode() {
        return payTypeCode;
    }

    public void setPayTypeCode(String payTypeCode) {
        this.payTypeCode = payTypeCode;
    }

    public Date getStartOrderDate() {
        return startOrderDate;
    }

    public void setStartOrderDate(Date startOrderDate) {
        this.startOrderDate = startOrderDate;
    }

    public Date getEndOrderDate() {
        return endOrderDate;
    }

    public void setEndOrderDate(Date endOrderDate) {
        this.endOrderDate = endOrderDate;
    }

    public Date getStartSendDate() {
        return startSendDate;
    }

    public void setStartSendDate(Date startSendDate) {
        this.startSendDate = startSendDate;
    }

    public Date getEndSendDate() {
        return endSendDate;
    }

    public void setEndSendDate(Date endSendDate) {
        this.endSendDate = endSendDate;
    }

    public Date getStartTakeDate() {
        return startTakeDate;
    }

    public void setStartTakeDate(Date startTakeDate) {
        this.startTakeDate = startTakeDate;
    }

    public Date getEndTakeDate() {
        return endTakeDate;
    }

    public void setEndTakeDate(Date endTakeDate) {
        this.endTakeDate = endTakeDate;
    }

    public String getProviceCode() {
        return proviceCode;
    }

    public void setProviceCode(String proviceCode) {
        this.proviceCode = proviceCode;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getCancelTypeCode() {
        return cancelTypeCode;
    }

    public void setCancelTypeCode(String cancelTypeCode) {
        this.cancelTypeCode = cancelTypeCode;
    }

    public Long getPreferentialAmt() {
        return preferentialAmt;
    }

    public void setPreferentialAmt(Long preferentialAmt) {
        this.preferentialAmt = preferentialAmt;
    }

    public String getConCode() {
        return conCode;
    }

    public void setConCode(String conCode) {
        this.conCode = conCode;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public Date getCancelTime() {
        return cancelTime;
    }

    public void setCancelTime(Date cancelTime) {
        this.cancelTime = cancelTime;
    }

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
    }

    public Date getStartPayDate() {
        return startPayDate;
    }

    public void setStartPayDate(Date startPayDate) {
        this.startPayDate = startPayDate;
    }

    public Date getEndPayDate() {
        return endPayDate;
    }

    public void setEndPayDate(Date endPayDate) {
        this.endPayDate = endPayDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public List<String> getSaleOrderNos() {
        return saleOrderNos;
    }

    public void setSaleOrderNos(List<String> saleOrderNos) {
        this.saleOrderNos = saleOrderNos;
    }

    public String getConsigneeUserName() {
        return consigneeUserName;
    }

    public void setConsigneeUserName(String consigneeUserName) {
        this.consigneeUserName = consigneeUserName;
    }

    public String getConsigneePhoneNo() {
        return consigneePhoneNo;
    }

    public void setConsigneePhoneNo(String consigneePhoneNo) {
        this.consigneePhoneNo = consigneePhoneNo;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getStrBeginOrderTime() {
        return strBeginOrderTime;
    }

    public void setStrBeginOrderTime(String strBeginOrderTime) {
        this.strBeginOrderTime = strBeginOrderTime;
    }

    public String getStrEndOrderTime() {
        return strEndOrderTime;
    }

    public void setStrEndOrderTime(String strEndOrderTime) {
        this.strEndOrderTime = strEndOrderTime;
    }

    public String getStrEndPriceTime() {
        return strEndPriceTime;
    }

    public void setStrEndPriceTime(String strEndPriceTime) {
        this.strEndPriceTime = strEndPriceTime;
    }

    public String getStrBeginPriceTime() {
        return strBeginPriceTime;
    }

    public void setStrBeginPriceTime(String strBeginPriceTime) {
        this.strBeginPriceTime = strBeginPriceTime;
    }

    public String getDateType() {
        return dateType;
    }

    public void setDateType(String dateType) {
        this.dateType = dateType;
    }

    public List<String> getStatusCodes() {
        return statusCodes;
    }

    public void setStatusCodes(List<String> statusCodes) {
        this.statusCodes = statusCodes;
    }

    public String getDeliveryMode() {
        return deliveryMode;
    }

    public void setDeliveryMode(String deliveryMode) {
        this.deliveryMode = deliveryMode;
    }
    
    public String getStrBeginTime() {
		return strBeginTime;
	}

	public void setStrBeginTime(String strBeginTime) {
		this.strBeginTime = strBeginTime;
	}

	public String getStrEndTime() {
		return strEndTime;
	}

	public void setStrEndTime(String strEndTime) {
		this.strEndTime = strEndTime;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Integer getAcceptUserId() {
		return acceptUserId;
	}

	public void setAcceptUserId(Integer acceptUserId) {
		this.acceptUserId = acceptUserId;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

}