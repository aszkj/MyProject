package com.yldbkd.www.seller.android.bean;

/**
 * 收货地址信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class ConsigneeAddress extends BaseModel {

    /**
     * 收货人
     */
    private String consignee;
    /**
     * 收货人电话
     */
    private String consMobile;
    /**
     * 收货地址
     */
    private String consAddress;
    /**
     * 送货距离单位米
     */
    private Integer distance;
    /**
     * 经度
     */
    private Double longitude;
    /**
     * 纬度
     */
    private Double latitude;

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getConsMobile() {
        return consMobile;
    }

    public void setConsMobile(String consMobile) {
        this.consMobile = consMobile;
    }

    public String getConsAddress() {
        return consAddress;
    }

    public void setConsAddress(String consAddress) {
        this.consAddress = consAddress;
    }

    public Integer getDistance() {
        return distance;
    }

    public void setDistance(Integer distance) {
        this.distance = distance;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }
}
