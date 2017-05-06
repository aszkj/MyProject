package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: 小区搜索
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class CommunitySearchVO extends AppBaseVO {

    private static final long serialVersionUID = -3486515332935455558L;

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
     * 地市编码
     */
    private String cityCode;

    /**
     * 地市名称
     */
    private String cityName;

    /**
     * 省编码
     */
    private String provinceCode;

    /**
     * 省名称
     */
    private String provinceName;
    /**
     * 区编码
     */
    private String countyCode;

    /**
     * 地区名称
     */
    private String countyName;

    /**
     * 店铺信息
     */
    private StoreInfoVO storeInfo;

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

    public StoreInfoVO getStoreInfo() {
        return storeInfo;
    }

    public void setStoreInfo(StoreInfoVO storeInfo) {
        this.storeInfo = storeInfo;
    }

}
