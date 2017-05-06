package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 商品信息数据类
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class SaleProduct extends ProductBase {
    /**
     * 商品零售价
     */
    private Long retailPrice;
    /**
     * 商品促销价
     */
    private Long promotionalPrice;
    /**
     * 商品条形码
     */
    private String barCode;

    /**
     * 商品活动信息列表
     */
    private List<ActivityData> activityInfoList;

    private boolean isCheck = true;

    public SaleProduct() {
    }

    public SaleProduct(int saleProductId, int cartNum, String productName, Long orderPrice,
                       Long promotionalPrice, Long retailPrice, int actId) {
        super(saleProductId, cartNum, productName, orderPrice, actId);
        this.promotionalPrice = promotionalPrice;
        this.retailPrice = retailPrice;
    }

    public Long getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(Long retailPrice) {
        this.retailPrice = retailPrice;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public boolean isCheck() {
        return isCheck;
    }

    public void setIsCheck(boolean isCheck) {
        this.isCheck = isCheck;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public List<ActivityData> getActivityInfoList() {
        return activityInfoList;
    }

    public void setActivityInfoList(List<ActivityData> activityInfoList) {
        this.activityInfoList = activityInfoList;
    }
}
