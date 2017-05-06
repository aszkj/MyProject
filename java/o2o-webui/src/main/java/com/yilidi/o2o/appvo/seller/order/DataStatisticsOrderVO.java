package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(订单结算统计信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:09:20
 */
public class DataStatisticsOrderVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 1572329695965986981L;
    /**
     * 统计日期
     */
    private String statisticDate;
    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 结算金额
     */
    private Long settleAmount;

    public String getStatisticDate() {
        return statisticDate;
    }

    public void setStatisticDate(String statisticDate) {
        this.statisticDate = statisticDate;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Long getSettleAmount() {
        return settleAmount;
    }

    public void setSettleAmount(Long settleAmount) {
        this.settleAmount = settleAmount;
    }
}
