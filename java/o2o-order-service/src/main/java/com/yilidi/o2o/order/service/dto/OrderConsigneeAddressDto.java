/**
 * 文件名称：OrderConsigneeAddressDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：订单收货地址模型DTO <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class OrderConsigneeAddressDto extends BaseDto {

    private static final long serialVersionUID = 4218937390934179627L;
    /**
     * 收货地址Id
     */
    private Integer id;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 收货人名称
     */
    private String userName;
    /**
     * 收货地址
     */
    private String addressDetail;
    /**
     * 收货人手机号码
     */
    private String phoneNo;
    /**
     * 所在经度，当前用户位置和小区距离大于配送范围，则使用小区位置，否则使用当前位置
     */
    private String longitude;
    /**
     * 所在纬度，当前用户位置和小区距离大于配送范围，则使用小区位置，否则使用当前位置
     */
    private String latitude;

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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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

}
