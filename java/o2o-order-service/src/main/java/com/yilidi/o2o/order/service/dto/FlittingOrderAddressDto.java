package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 调拨单收货地址信息
 * 
 * @author simpson
 * 
 */
public class FlittingOrderAddressDto extends BaseDto {

    private static final long serialVersionUID = -3212423096044628105L;
    /**
     * 调拨收货地址ID，主键自增
     */
    private Integer id;
    /**
     * 调拨单编号
     */
    private String flittingOrderNo;
    /**
     * 收货人名称
     */
    private String userName;
    /**
     * 收货地址
     */
    private String addressDetail;
    /**
     * 手机号码
     */
    private String phoneNo;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFlittingOrderNo() {
        return flittingOrderNo;
    }

    public void setFlittingOrderNo(String flittingOrderNo) {
        this.flittingOrderNo = flittingOrderNo;
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

}
