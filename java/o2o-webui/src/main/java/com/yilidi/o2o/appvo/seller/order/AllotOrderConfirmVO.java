package com.yilidi.o2o.appvo.seller.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(调货单确认信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:08:03
 */
public class AllotOrderConfirmVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -8386335886947054319L;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 店铺收货地址
     */
    private String storeAddress;
    /**
     * 微仓名称
     */
    private String warehouseName;
    /**
     * 调货商品数量
     */
    private Integer allotTotalCount;
    /**
     * 调货商品金额
     */
    private Long allotTotalAmount;
    /**
     * 最小生成调货单金额
     */
    private Long minAllotAmount;
    /**
     * 最大生成调货单金额
     */
    private Long maxAllotAmount;
    /**
     * 调货产品列表
     */
    private List<SaleProductAllotVO> saleProductList;

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

    public String getStoreAddress() {
        return storeAddress;
    }

    public void setStoreAddress(String storeAddress) {
        this.storeAddress = storeAddress;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public Integer getAllotTotalCount() {
        return allotTotalCount;
    }

    public void setAllotTotalCount(Integer allotTotalCount) {
        this.allotTotalCount = allotTotalCount;
    }

    public Long getAllotTotalAmount() {
        return allotTotalAmount;
    }

    public void setAllotTotalAmount(Long allotTotalAmount) {
        this.allotTotalAmount = allotTotalAmount;
    }

    public Long getMinAllotAmount() {
        return minAllotAmount;
    }

    public void setMinAllotAmount(Long minAllotAmount) {
        this.minAllotAmount = minAllotAmount;
    }

    public Long getMaxAllotAmount() {
        return maxAllotAmount;
    }

    public void setMaxAllotAmount(Long maxAllotAmount) {
        this.maxAllotAmount = maxAllotAmount;
    }

    public List<SaleProductAllotVO> getSaleProductList() {
        return saleProductList;
    }

    public void setSaleProductList(List<SaleProductAllotVO> saleProductList) {
        this.saleProductList = saleProductList;
    }
}