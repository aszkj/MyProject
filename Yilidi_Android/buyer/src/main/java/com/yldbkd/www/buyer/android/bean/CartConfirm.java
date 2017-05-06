package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 购物车确认信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class CartConfirm extends BaseModel {

    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * vip商品标识 0不是  1 是
     */
    private Integer isVipOrder;
    /**
     * 订单产品项目列表
     */
    private List<SaleProduct> saleOrderItemList;
    /**
     * 订单赠品项目列表
     */
    private GiftInfo giftInfo;
    /**
     * 订单费用信息
     */
    private OrderFee orderFeeInfo;
    /**
     * 奖券信息是否是单选：（类型之间属于互斥关系）
     * 0：多选（可选择多张满足条件奖券）
     * 1：单选
     */
    private Integer isTicketSingleSelection;
    /**
     * 多奖券类型信息
     */
    private List<TicketTypes> ticketTypes;


    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public List<SaleProduct> getSaleOrderItemList() {
        return saleOrderItemList;
    }

    public void setSaleOrderItemList(List<SaleProduct> saleOrderItemList) {
        this.saleOrderItemList = saleOrderItemList;
    }

    public OrderFee getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFee orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }

    public Integer getIsVipOrder() {
        return isVipOrder == null ? null : isVipOrder;
    }

    public void setIsVipOrder(Integer isVipOrder) {
        this.isVipOrder = isVipOrder;
    }

    public Integer getIsTicketSingleSelection() {
        return isTicketSingleSelection;
    }

    public void setIsTicketSingleSelection(Integer isTicketSingleSelection) {
        this.isTicketSingleSelection = isTicketSingleSelection;
    }

    public List<TicketTypes> getTicketTypes() {
        return ticketTypes;
    }

    public void setTicketTypes(List<TicketTypes> ticketTypes) {
        this.ticketTypes = ticketTypes;
    }

    public GiftInfo getGiftInfo() {
        return giftInfo;
    }

    public void setGiftInfo(GiftInfo giftInfo) {
        this.giftInfo = giftInfo;
    }
}
