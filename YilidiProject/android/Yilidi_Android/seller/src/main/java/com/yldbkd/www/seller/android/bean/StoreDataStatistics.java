package com.yldbkd.www.seller.android.bean;

/**
 * 店铺首页统计数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class StoreDataStatistics extends BaseModel {

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
