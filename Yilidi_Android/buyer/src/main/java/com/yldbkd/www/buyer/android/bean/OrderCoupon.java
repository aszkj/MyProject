package com.yldbkd.www.buyer.android.bean;

/**
 * 购物车确认信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class OrderCoupon extends BaseModel {

    /**
     * 订单费用信息
     */
    private OrderFee orderFeeInfo;

    public OrderFee getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFee orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }
}
