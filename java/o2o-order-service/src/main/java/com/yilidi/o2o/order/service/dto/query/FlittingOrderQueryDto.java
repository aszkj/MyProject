package com.yilidi.o2o.order.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 调拨单查询
 * 
 * @author simpson
 * 
 */
public class FlittingOrderQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 5224918426447368113L;
    /**
     * 调拨单号
     */
    private String flittingOrderNo;
    /**
     * 调拨状态
     */
    private String orderStatus;
    /**
     * 排除的调拨状态
     */
    private String excludeOrderStatus;
    /**
     * 调拨申请开始时间
     */
    private Date beginCreateTime;
    /**
     * 调拨申请结束时间
     */
    private Date endCreateTime;
    /**
     * 调出店铺模糊字符串
     */
    private String srcStoreName;
    /**
     * 调入店铺模糊字符串
     */
    private String destStoreName;
    /**
     * 调出店铺ID
     */
    private Integer srcStoreId;
    /**
     * 调入店铺ID
     */
    private Integer destStoreId;
    /**
     * 调出店铺省份
     */
    private String srcProvinceCode;
    /**
     * 调出店铺城市
     */
    private String srcCityCode;
    /**
     * 调出店铺县区
     */
    private String srcCountyCode;
    /**
     * 调入店铺省份
     */
    private String destProvinceCode;
    /**
     * 调入店铺城市
     */
    private String destCityCode;
    /**
     * 调入店铺县区
     */
    private String destCountyCode;

    /**
     * 调拨申请开始时间字符串
     */
    private String strBeginCreateTime;
    /**
     * 调拨申请结束时间字符串
     */
    private String strEndCreateTime;

    /**
     * 调拨状态列表
     */
    private List<String> orderStatusList;

    public String getFlittingOrderNo() {
        return flittingOrderNo;
    }

    public void setFlittingOrderNo(String flittingOrderNo) {
        this.flittingOrderNo = flittingOrderNo;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getExcludeOrderStatus() {
        return excludeOrderStatus;
    }

    public void setExcludeOrderStatus(String excludeOrderStatus) {
        this.excludeOrderStatus = excludeOrderStatus;
    }

    public Date getBeginCreateTime() {
        return beginCreateTime;
    }

    public void setBeginCreateTime(Date beginCreateTime) {
        this.beginCreateTime = beginCreateTime;
    }

    public Date getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(Date endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public String getSrcStoreName() {
        return srcStoreName;
    }

    public void setSrcStoreName(String srcStoreName) {
        this.srcStoreName = srcStoreName;
    }

    public String getDestStoreName() {
        return destStoreName;
    }

    public void setDestStoreName(String destStoreName) {
        this.destStoreName = destStoreName;
    }

    public Integer getSrcStoreId() {
        return srcStoreId;
    }

    public void setSrcStoreId(Integer srcStoreId) {
        this.srcStoreId = srcStoreId;
    }

    public Integer getDestStoreId() {
        return destStoreId;
    }

    public void setDestStoreId(Integer destStoreId) {
        this.destStoreId = destStoreId;
    }

    public String getSrcProvinceCode() {
        return srcProvinceCode;
    }

    public void setSrcProvinceCode(String srcProvinceCode) {
        this.srcProvinceCode = srcProvinceCode;
    }

    public String getSrcCityCode() {
        return srcCityCode;
    }

    public void setSrcCityCode(String srcCityCode) {
        this.srcCityCode = srcCityCode;
    }

    public String getSrcCountyCode() {
        return srcCountyCode;
    }

    public void setSrcCountyCode(String srcCountyCode) {
        this.srcCountyCode = srcCountyCode;
    }

    public String getDestProvinceCode() {
        return destProvinceCode;
    }

    public void setDestProvinceCode(String destProvinceCode) {
        this.destProvinceCode = destProvinceCode;
    }

    public String getDestCityCode() {
        return destCityCode;
    }

    public void setDestCityCode(String destCityCode) {
        this.destCityCode = destCityCode;
    }

    public String getDestCountyCode() {
        return destCountyCode;
    }

    public void setDestCountyCode(String destCountyCode) {
        this.destCountyCode = destCountyCode;
    }

    public String getStrBeginCreateTime() {
        return strBeginCreateTime;
    }

    public void setStrBeginCreateTime(String strBeginCreateTime) {
        this.strBeginCreateTime = strBeginCreateTime;
    }

    public String getStrEndCreateTime() {
        return strEndCreateTime;
    }

    public void setStrEndCreateTime(String strEndCreateTime) {
        this.strEndCreateTime = strEndCreateTime;
    }

    public List<String> getOrderStatusList() {
        return orderStatusList;
    }

    public void setOrderStatusList(List<String> orderStatusList) {
        this.orderStatusList = orderStatusList;
    }

}
