package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(统计信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:08:56
 */
public class DataStatisticsVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -4113051682938549339L;
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
