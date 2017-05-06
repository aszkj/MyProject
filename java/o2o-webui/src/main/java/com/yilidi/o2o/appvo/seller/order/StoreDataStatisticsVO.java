package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(店铺首页统计数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:13:52
 */
public class StoreDataStatisticsVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 7353686492918092658L;
    /**
     * 邀请注册用户数
     */
    private Integer inviteCount;
    /**
     * 待接单数量
     */
    private Integer forAcceptOrderCount;
    /**
     * 完成订单金额
     */
    private Long finishOrderAmount;
    /**
     * VIP用户数
     */
    private Integer vipUserCount;
    /**
     * 本周预返款
     */
    private Long currentWeekAmount;
    /**
     * 上周已返款
     */
    private Long lastWeekAmount;

    public Integer getInviteCount() {
        return inviteCount;
    }

    public void setInviteCount(Integer inviteCount) {
        this.inviteCount = inviteCount;
    }

    public Integer getForAcceptOrderCount() {
        return forAcceptOrderCount;
    }

    public void setForAcceptOrderCount(Integer forAcceptOrderCount) {
        this.forAcceptOrderCount = forAcceptOrderCount;
    }

    public Long getFinishOrderAmount() {
        return finishOrderAmount;
    }

    public void setFinishOrderAmount(Long finishOrderAmount) {
        this.finishOrderAmount = finishOrderAmount;
    }

    public Integer getVipUserCount() {
        return vipUserCount;
    }

    public void setVipUserCount(Integer vipUserCount) {
        this.vipUserCount = vipUserCount;
    }

    public Long getCurrentWeekAmount() {
        return currentWeekAmount;
    }

    public void setCurrentWeekAmount(Long currentWeekAmount) {
        this.currentWeekAmount = currentWeekAmount;
    }

    public Long getLastWeekAmount() {
        return lastWeekAmount;
    }

    public void setLastWeekAmount(Long lastWeekAmount) {
        this.lastWeekAmount = lastWeekAmount;
    }
}
