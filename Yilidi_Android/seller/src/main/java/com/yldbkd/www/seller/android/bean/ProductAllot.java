package com.yldbkd.www.seller.android.bean;

/**
 * 调货相关商品信息数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class ProductAllot extends ProductBase {

    /**
     * 产品进货价
     */
    private Long basePrice;
    /**
     * 微仓库存
     */
    private Integer warehouseCount;
    /**
     * 剩余库存
     */
    private Integer remainCount;
    /**
     * 每次调拨操作单位数量
     */
    private Integer perAllotCount;
    /**
     * 商品调拨数量
     */
    private Integer allotCount;
    /**
     * 商品实际调拨数量
     */
    private Integer realAllotCount;

    private int cartNum = 0;

    private boolean isCheck = true;

    private Integer operateAllotCount; // 操作的调入数量

    public Long getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(Long basePrice) {
        this.basePrice = basePrice;
    }

    public Integer getWarehouseCount() {
        return warehouseCount == null ? 0 : warehouseCount;
    }

    public void setWarehouseCount(Integer warehouseCount) {
        this.warehouseCount = warehouseCount;
    }

    public Integer getRemainCount() {
        return remainCount == null ? 0 : remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getPerAllotCount() {
        return perAllotCount;
    }

    public void setPerAllotCount(Integer perAllotCount) {
        this.perAllotCount = perAllotCount;
    }

    public Integer getAllotCount() {
        return allotCount == null ? 0 : allotCount;
    }

    public void setAllotCount(Integer allotCount) {
        this.allotCount = allotCount;
    }

    public Integer getRealAllotCount() {
        return realAllotCount;
    }

    public void setRealAllotCount(Integer realAllotCount) {
        this.realAllotCount = realAllotCount;
    }

    public int getCartNum() {
        return cartNum;
    }

    public void setCartNum(int cartNum) {
        this.cartNum = cartNum;
    }

    public boolean isCheck() {
        return isCheck;
    }

    public void setCheck(boolean check) {
        isCheck = check;
    }

    public Integer getOperateAllotCount() {
        if (operateAllotCount == null) {
            operateAllotCount = getAllotCount();
        }
        return operateAllotCount;
    }

    public void setOperateAllotCount(Integer operateAllotCount) {
        this.operateAllotCount = operateAllotCount;
    }
}
