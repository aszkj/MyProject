package com.yilidi.o2o.order.service.dto.query;

import java.util.List;

import com.yilidi.o2o.core.model.BaseQueryDto;

public class SellerListOrderQueryDto extends BaseQueryDto {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -6344167091127373329L;
    /**
     * 用户id
     */
    private Integer userId;
    
    /**
     * 主账号标识
     */
    private String masterFlag;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 查询订单列表状态类型List
     */
    private List<String> statusCodeList;

    /**
     * 店铺所在经度
     */
    private String longitude;

    /**
     * 店铺所在纬度
     */
    private String latitude;

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

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public List<String> getStatusCodeList() {
        return statusCodeList;
    }

    public void setStatusCodeList(List<String> statusCodeList) {
        this.statusCodeList = statusCodeList;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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
