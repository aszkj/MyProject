package com.yldbkd.www.buyer.android.bean;

/**
 * 地址信息数据类
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class AddressBase extends BaseModel {
    /**
     * 地址信息ID
     */
    private Integer addressId;
    /**
     * 收货人姓名
     */
    private String consigneeName;
    /**
     * 手机号
     */
    private String phoneNo;
    /**
     * 小区信息数据
     */
    private Community community;
    /**
     * 收货地址详细地址信息
     */
    private String addressDetail;
    /**
     * 订单详情详细地址
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

    public Community getCommunity() {
        return community;
    }

    public void setCommunity(Community community) {
        this.community = community;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getAddress() {
        if (this.address == null) {
            return getCommunity().getCommunityName()+getCommunity().getAddressDetail();
        }
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
