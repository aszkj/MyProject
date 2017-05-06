package com.yldbkd.www.buyer.android.bean;

/**
 * 店铺信息数据类
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class Store extends BaseModel {
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 店铺营业开始时间
     */
    private String businessHoursBegin;
    /**
     * 店铺营业结束时间
     */
    private String businessHoursEnd;
    /**
     * 满减达标金额（店铺满多少免运费）
     */
    private Long deduceTransCostAmount;
    /**
     * 运费金额
     */
    private Long transCostAmount;
    /**
     * 店铺状态
     * 见Constants.StoreStatus
     * 0 -  暂停营业
     * 1 -  正常营业
     */
    private String storeStatus;
    /**
     * 店铺热线
     */
    private String hotline;
    /**
     * 店铺评分
     */
    private Float storeScore = 5f;
    /**
     * 店铺地址
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
     * 订单详情详细地址
     */
    private String address;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getBusinessHoursBegin() {
        return businessHoursBegin;
    }

    public void setBusinessHoursBegin(String businessHoursBegin) {
        this.businessHoursBegin = businessHoursBegin;
    }

    public String getBusinessHoursEnd() {
        return businessHoursEnd;
    }

    public void setBusinessHoursEnd(String businessHoursEnd) {
        this.businessHoursEnd = businessHoursEnd;
    }

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

    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
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

    public String getAddress() {
        if (this.address == null) {
            return getProvinceName() + getCityName() + getCountyName() + getAddressDetail();
        }
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Float getStoreScore() {
        return storeScore;
    }

    public void setStoreScore(Float storeScore) {
        this.storeScore = storeScore;
    }
}
