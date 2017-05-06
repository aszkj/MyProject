package com.yilidi.o2o.appvo.seller.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(收货地址信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:12:18
 */
public class ConsigneeAddressVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 5280350718917763626L;
    /**
     * 用户名称
     */
    private String consignee;
    /**
     * 手机号
     */
    private String consMobile;
    /**
     * 地址信息
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
