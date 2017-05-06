package com.yilidi.o2o.appvo.buyer.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.appvo.buyer.user.StoreInfoVO;

/**
 * 订单详细
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class OrderDetailVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 收货码
     */
    private String receiveNo;
    /**
     * 订单信息
     */
    private OrderBaseInfoVO orderBaseInfo;
    /**
     * 店铺信息
     */
    private StoreInfoVO storeInfo;

    /**
     * 订单费用信息
     */
    private OrderFeeInfoVO orderFeeInfo;
    /**
     * 地址信息
     */
    private ConsigneeAddressBeanVO consigneeAddressBean;
    /**
     * 商品列表
     */
    private List<OrderDetailItemVO> saleOrderItemList;
    /**
     * 订单状态列表
     */
    private List<OrderDetailStatusVO> orderStatusList;

    /**
     * 赠品信息
     */
    private GiftInfoVO giftInfo;

    public String getReceiveNo() {
        return receiveNo;
    }

    public void setReceiveNo(String receiveNo) {
        this.receiveNo = receiveNo;
    }

    public OrderBaseInfoVO getOrderBaseInfo() {
        return orderBaseInfo;
    }

    public void setOrderBaseInfo(OrderBaseInfoVO orderBaseInfo) {
        this.orderBaseInfo = orderBaseInfo;
    }

    public OrderFeeInfoVO getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFeeInfoVO orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }

    public ConsigneeAddressBeanVO getConsigneeAddressBean() {
        return consigneeAddressBean;
    }

    public void setConsigneeAddressBean(ConsigneeAddressBeanVO consigneeAddressBean) {
        this.consigneeAddressBean = consigneeAddressBean;
    }

    public List<OrderDetailItemVO> getSaleOrderItemList() {
        return saleOrderItemList;
    }

    public void setSaleOrderItemList(List<OrderDetailItemVO> saleOrderItemList) {
        this.saleOrderItemList = saleOrderItemList;
    }

    public List<OrderDetailStatusVO> getOrderStatusList() {
        return orderStatusList;
    }

    public void setOrderStatusList(List<OrderDetailStatusVO> orderStatusList) {
        this.orderStatusList = orderStatusList;
    }

    public StoreInfoVO getStoreInfo() {
        return storeInfo;
    }

    public void setStoreInfo(StoreInfoVO storeInfo) {
        this.storeInfo = storeInfo;
    }

    public GiftInfoVO getGiftInfo() {
        return giftInfo;
    }

    public void setGiftInfo(GiftInfoVO giftInfo) {
        this.giftInfo = giftInfo;
    }

}
