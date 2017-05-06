package com.yilidi.o2o.order.model.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

public class SellerListOrderQuery extends BaseQuery {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -6344167091127373329L;

    /**
     * 查询订单列表状态类型List
     */
    private List<String> statusCodeList;
    
    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 用户标识
     */
    private String masterFlag;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 搜索关键字(收货人姓名、收货人手机号、订单编号)
     */
    private String keyword;

    /**
     * 付款状态
     */
    private String payStatus;

    /**
     * 订单类型编码List
     */
    private List<String> orderTypeCodeList;

    /**
     * 配送方式编码
     */
    private String deliveryTypeCode;

    public List<String> getStatusCodeList() {
        return statusCodeList;
    }

    public void setStatusCodeList(List<String> statusCodeList) {
        this.statusCodeList = statusCodeList;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getPayStatus() {
        return payStatus;
    }

    public void setPayStatus(String payStatus) {
        this.payStatus = payStatus;
    }

    public List<String> getOrderTypeCodeList() {
        return orderTypeCodeList;
    }

    public void setOrderTypeCodeList(List<String> orderTypeCodeList) {
        this.orderTypeCodeList = orderTypeCodeList;
    }

    public String getDeliveryTypeCode() {
        return deliveryTypeCode;
    }

    public void setDeliveryTypeCode(String deliveryTypeCode) {
        this.deliveryTypeCode = deliveryTypeCode;
    }

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getMasterFlag() {
		return masterFlag;
	}

	public void setMasterFlag(String masterFlag) {
		this.masterFlag = masterFlag;
	}

}
