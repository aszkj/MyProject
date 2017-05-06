package com.yilidi.o2o.appvo.buyer.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 购物车列表
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class ShopCartListVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 店铺营业开店时间
     */
    private String businessHoursBegin;

    /**
     * 店铺营业关店时间
     */
    private String businessHoursEnd;

    /**
     * 店铺满多少免运费
     */
    private Long deduceTransCostAmount;

    /**
     * 店铺运费
     */
    private Long transCostAmount;
    /**
     * 店铺状态 0-暂停营业 ,1-正常营业
     */
    private String storeStatus;
    /**
     * 店铺详细地址
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
     * 地区编码
     */
    private String countyCode;

    /**
     * 地区名称
     */
    private String countyName;
    /**
     * 送货时间说明
     */
    private String deliveryTimeNote;
    /**
     * 自提时间说明
     */
    private String pickUpTimeNote;
    /**
     * 产品列表
     */
    private List<ShopCartSaleProductListVO> saleProductList;

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

    public String getPickUpTimeNote() {
        return pickUpTimeNote;
    }

    public void setPickUpTimeNote(String pickUpTimeNote) {
        this.pickUpTimeNote = pickUpTimeNote;
    }

    public String getDeliveryTimeNote() {
        return deliveryTimeNote;
    }

    public void setDeliveryTimeNote(String deliveryTimeNote) {
        this.deliveryTimeNote = deliveryTimeNote;
    }

    public List<ShopCartSaleProductListVO> getSaleProductList() {
        return saleProductList;
    }

    public void setSaleProductList(List<ShopCartSaleProductListVO> saleProductList) {
        this.saleProductList = saleProductList;
    }

}
