/**
 * 文件名称：SaleOrderQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.model.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：订单查询条件封装类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderQuery extends BaseQuery {
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
     * 客户ID
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
     * 支付平台编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERPAYPLATFORM)
     */
    private String payPlatformCode;

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
     * 订单是否已评价，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=APPRAISEFLAG)
     */
    private String appraiseFlag;
    
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

    public String getPayPlatformCode() {
        return payPlatformCode;
    }

    public void setPayPlatformCode(String payPlatformCode) {
        this.payPlatformCode = payPlatformCode;
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

    public List<String> getStatusCodes() {
        return statusCodes;
    }

    public void setStatusCodes(List<String> statusCodes) {
        this.statusCodes = statusCodes;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

	public Integer getAcceptUserId() {
		return acceptUserId;
	}

	public void setAcceptUserId(Integer acceptUserId) {
		this.acceptUserId = acceptUserId;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

}