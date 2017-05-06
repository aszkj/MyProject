package com.yilidi.o2o.appvo.seller.order;

/**
 * @Description: TODO(订单配送信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 下午4:39:08
 */
public class OrderDeliveryVO extends OrderStatusVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -5032122769817788820L;
    /**
     * 配送时间
     */
    private String deliveryTime;

    public String getDeliveryTime() {
        return deliveryTime;
    }

    public void setDeliveryTime(String deliveryTime) {
        this.deliveryTime = deliveryTime;
    }
}
