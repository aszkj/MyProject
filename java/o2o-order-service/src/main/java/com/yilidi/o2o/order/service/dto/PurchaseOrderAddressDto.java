package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 采购单收货地址信息
 * 
 * @author chenb
 * 
 */
public class PurchaseOrderAddressDto extends BaseDto {
    private static final long serialVersionUID = 4394616624817172255L;
    /**
     * 采购收货地址ID，主键自增
     */
    private Integer id;
    /**
     * 采购单编号
     */
    private String purchaseOrderNo;
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

    public String getPurchaseOrderNo() {
        return purchaseOrderNo;
    }

    public void setPurchaseOrderNo(String purchaseOrderNo) {
        this.purchaseOrderNo = purchaseOrderNo;
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
