package com.yldbkd.www.seller.android.bean;

/**
 * 订单结算统计信息数据
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class DataStatisticsOrder extends BaseModel {

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
