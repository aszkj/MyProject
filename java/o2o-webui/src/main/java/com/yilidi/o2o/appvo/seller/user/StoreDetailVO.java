package com.yilidi.o2o.appvo.seller.user;

/**
 * @Description: TODO(店铺详细信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:14:06
 */
public class StoreDetailVO extends StoreBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -1912449622170144387L;
    /**
     * 店铺满多少免运费
     */
    private Long deduceTransCostAmount;
    /**
     * 店铺运费
     */
    private Long transCostAmount;
    /**
     * 店铺热线
     */
    private String hotline;
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
     * 地区编码
     */
    private String countyCode;
    /**
     * 地区名称
     */
    private String countyName;
    /**
     * 详细地址信息
     */
    private String addressDetail;
    /**
     * 小区ID
     */
    private Integer communityId;
    /**
     * 小区名称
     */
    private String communityName;
    /**
     * 店铺状态 0- 暂停营业 1- 正常营业
     */
    private Integer storeStatus;

    public Long getDeduceTransCostAmount() {
        return deduceTransCostAmount;
    }

    public void setDeduceTransCostAmount(Long deduceTransCostAmount) {
        this.deduceTransCostAmount = deduceTransCostAmount;
    }

    public Long getTransCostAmount() {
        return transCostAmount;
    }

    public void setTransCostAmount(Long transCostAmount) {
        this.transCostAmount = transCostAmount;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
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

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

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

    public Integer getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(Integer storeStatus) {
        this.storeStatus = storeStatus;
    }

}
