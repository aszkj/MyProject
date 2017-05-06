package com.yilidi.o2o.appvo.buyer.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单结算
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class SettlementOrderVO extends AppBaseVO {

    private static final long serialVersionUID = 1385906458487098433L;
    /**
     * 店铺名称
     */
    private String storeName;
    /**
     * 是否是VIP预订单,0-不是,1-是
     */
    private Integer isVipOrder;
    /**
     * 订单产品项目列表
     */
    private List<SettleOrderItemVO> saleOrderItemList;
    /**
     * 订单费用信息
     */
    private OrderFeeInfoVO orderFeeInfo;
    /**
     * 奖券信息是否是单选：（类型之间属于互斥关系）<br>
     * 0：多选（可选择多张满足条件奖券）<br>
     * 1：单选
     */
    private Integer isTicketSingleSelection;
    /**
     * 多奖券类型信息：每一种类型下包含了该类型的多张有效的奖券信息
     */
    private List<SettlementOrderTicketListVO> ticketTypes;
    /**
     * 赠品信息
     */
    private GiftInfoVO giftInfo;

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public Integer getIsVipOrder() {
        return isVipOrder;
    }

    public void setIsVipOrder(Integer isVipOrder) {
        this.isVipOrder = isVipOrder;
    }

    public List<SettleOrderItemVO> getSaleOrderItemList() {
        return saleOrderItemList;
    }

    public void setSaleOrderItemList(List<SettleOrderItemVO> saleOrderItemList) {
        this.saleOrderItemList = saleOrderItemList;
    }

    public OrderFeeInfoVO getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFeeInfoVO orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }

    public Integer getIsTicketSingleSelection() {
        return isTicketSingleSelection;
    }

    public void setIsTicketSingleSelection(Integer isTicketSingleSelection) {
        this.isTicketSingleSelection = isTicketSingleSelection;
    }

    public List<SettlementOrderTicketListVO> getTicketTypes() {
        return ticketTypes;
    }

    public void setTicketTypes(List<SettlementOrderTicketListVO> ticketTypes) {
        this.ticketTypes = ticketTypes;
    }

    public GiftInfoVO getGiftInfo() {
        return giftInfo;
    }

    public void setGiftInfo(GiftInfoVO giftInfo) {
        this.giftInfo = giftInfo;
    }

}
