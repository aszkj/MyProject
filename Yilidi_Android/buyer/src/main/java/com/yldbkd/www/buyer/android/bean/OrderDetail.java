package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 订单详细信息数据类
 * <p/>
 * Created by linghuxj on 15/10/16.
 */
public class OrderDetail extends BaseModel {

    /**
     * 收货码
     */
    private String receiveNo;
    /**
     * 订单信息
     */
    private OrderBase orderBaseInfo;
    /**
     * 订单费用信息
     */
    private OrderFee orderFeeInfo;
    /**
     * 地址信息
     */
    private AddressBase consigneeAddressBean;
    /**
     * 店铺信息
     */
    private Store storeInfo;
    /**
     * 订单赠品信息
     */
    private GiftInfo giftInfo;
    /**
     * 商品列表
     */
    private List<SaleProduct> saleOrderItemList;
    /**
     * 订单状态列表
     */
    private List<OrderStatus> orderStatusList;

    public String getReceiveNo() {
        return receiveNo;
    }

    public void setReceiveNo(String receiveNo) {
        this.receiveNo = receiveNo;
    }

    public OrderBase getOrderBaseInfo() {
        return orderBaseInfo;
    }

    public void setOrderBaseInfo(OrderBase orderBaseInfo) {
        this.orderBaseInfo = orderBaseInfo;
    }

    public OrderFee getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFee orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }

    public AddressBase getConsigneeAddressBean() {
        return consigneeAddressBean;
    }

    public void setConsigneeAddressBean(AddressBase consigneeAddressBean) {
        this.consigneeAddressBean = consigneeAddressBean;
    }

    public List<SaleProduct> getSaleOrderItemList() {
        return saleOrderItemList;
    }

    public void setSaleOrderItemList(List<SaleProduct> saleOrderItemList) {
        this.saleOrderItemList = saleOrderItemList;
    }

    public List<OrderStatus> getOrderStatusList() {
        return orderStatusList;
    }

    public void setOrderStatusList(List<OrderStatus> orderStatusList) {
        this.orderStatusList = orderStatusList;
    }

    public Store getStoreInfo() {
        return storeInfo;
    }

    public void setStoreInfo(Store storeInfo) {
        this.storeInfo = storeInfo;
    }

    public GiftInfo getGiftInfo() {
        return giftInfo;
    }

    public void setGiftInfo(GiftInfo giftInfo) {
        this.giftInfo = giftInfo;
    }
}
