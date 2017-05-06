package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 购物车奖券结算信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class SettlementOrderTicketsVO extends AppBaseVO {

    private static final long serialVersionUID = 1385906458487098433L;
    /**
     * 订单费用信息
     */
    private OrderFeeInfoVO orderFeeInfo;

    public OrderFeeInfoVO getOrderFeeInfo() {
        return orderFeeInfo;
    }

    public void setOrderFeeInfo(OrderFeeInfoVO orderFeeInfo) {
        this.orderFeeInfo = orderFeeInfo;
    }

}
