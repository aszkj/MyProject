package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class ConsigneeAddressBeanVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;
    /** 收货地址ID **/
    private Integer addressId;
    /**
     * 用户名称
     */
    private String consigneeName;
    /**
     * 手机号
     */
    private String phoneNo;
    /**
     * 地址信息
     */
    private String address;

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public String getConsigneeName() {
        return consigneeName;
    }

    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}
