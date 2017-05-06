package com.yldbkd.www.seller.android.bean;

/**
 * 统计信息数据
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class DataStatistics extends BaseModel {

    /**
     * 铂金会员数量
     */
    private Integer vipUserCount;
    /**
     * 完成订单数
     */
    private Integer finishOrderCount;
    /**
     * 订单结算金额
     */
    private Long orderSettleAmount;

    public Integer getVipUserCount() {
        return vipUserCount;
    }

    public void setVipUserCount(Integer vipUserCount) {
        this.vipUserCount = vipUserCount;
    }

    public Integer getFinishOrderCount() {
        return finishOrderCount;
    }

    public void setFinishOrderCount(Integer finishOrderCount) {
        this.finishOrderCount = finishOrderCount;
    }

    public Long getOrderSettleAmount() {
        return orderSettleAmount;
    }

    public void setOrderSettleAmount(Long orderSettleAmount) {
        this.orderSettleAmount = orderSettleAmount;
    }
}
