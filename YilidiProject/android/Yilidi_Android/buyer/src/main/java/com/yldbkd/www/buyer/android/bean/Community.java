package com.yldbkd.www.buyer.android.bean;

/**
 * 小区信息数据bean
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class Community extends BaseModel {
    /**
     * 小区ID
     */
    private Integer communityId;
    /**
     * 小区名称
     */
    private String communityName;
    /**
     * 小区详细地址
     */
    private String addressDetail;
    /**
     * 省编码
     */
    private String provinceCode;
    /**
     * 省名称
     */
    private String provinceName;
    /**
     * 地市编码
     */
    private String cityCode;
    /**
     * 地市名称
     */
    private String cityName;
    /**
     * 地区编码
     */
    private String countyCode;
    /**
     * 地区名称
     */
    private String countyName;
    /**
     * 所在店铺信息
     */
    private Store storeInfo;

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCityName() {
        return cityName;
    }

    public void setCityName(String cityName) {
        this.cityName = cityName;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getCountyName() {
        return countyName;
    }

    public void setCountyName(String countyName) {
        this.countyName = countyName;
    }

    public Store getStoreInfo() {
        return storeInfo;
    }

    public void setStoreInfo(Store storeInfo) {
        this.storeInfo = storeInfo;
    }
}
