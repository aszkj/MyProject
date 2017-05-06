package com.yilidi.o2o.appvo.seller.order;

/**
 * @Description: TODO(订单接单信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 下午4:34:12
 */
public class OrderAcceptVO extends OrderStatusVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -5032122769817788820L;
    /**
     * 接单时间
     */
    private String acceptTime;

    public String getAcceptTime() {
        return acceptTime;
    }

    public void setAcceptTime(String acceptTime) {
        this.acceptTime = acceptTime;
    }
}
