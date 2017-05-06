package com.yldbkd.www.seller.android.bean;

/**
 * 店铺首页统计数据
 * <p/>
 * Created by linghuxj on 16/5/28.
 */
public class SummerizeTotal extends BaseModel {

    /**
     * 当日订单总数量
     */
    private Integer orderTotalCountToday;
    /**
     * 当日订单总金额
     */
    private Long orderTotalAmtToday;
    /**
     * 应结算订单总数量
     */
    private Integer shouldSettleOrderCount;
    /**
     * 应结算订单总金额
     */
    private Long shouldSettleOrderAmt;
    /**
     * 已结算订单总数量
     */
    private Integer settledOrderCount;
    /**
     * 已结算订单总金额
     */
    private Long settledOrderAmt;
    /**
     * 当日推广VIP用户总数量
     */
    private Integer inviteVIPCountToday;
    /**
     * 当日推广VIP用户总金额
     */
    private Long inviteVIPAmtToday;
    /**
     * 应结算推广费总数量
     */
    private Integer shouldSettleInviteCount;
    /**
     * 应结算推广费总金额
     */
    private Long shouldSettleInviteAmt;
    /**
     * 已结算推广费总数量
     */
    private Integer settledInviteCount;
    /**
     * 已结算推广费总金额
     */
    private Long settledInviteAmt;

    public Integer getOrderTotalCountToday() {
        return orderTotalCountToday;
    }

    public void setOrderTotalCountToday(Integer orderTotalCountToday) {
        this.orderTotalCountToday = orderTotalCountToday;
    }

    public Long getOrderTotalAmtToday() {
        return orderTotalAmtToday;
    }

    public void setOrderTotalAmtToday(Long orderTotalAmtToday) {
        this.orderTotalAmtToday = orderTotalAmtToday;
    }

    public Integer getShouldSettleOrderCount() {
        return shouldSettleOrderCount;
    }

    public void setShouldSettleOrderCount(Integer shouldSettleOrderCount) {
        this.shouldSettleOrderCount = shouldSettleOrderCount;
    }

    public Long getShouldSettleOrderAmt() {
        return shouldSettleOrderAmt;
    }

    public void setShouldSettleOrderAmt(Long shouldSettleOrderAmt) {
        this.shouldSettleOrderAmt = shouldSettleOrderAmt;
    }

    public Integer getSettledOrderCount() {
        return settledOrderCount;
    }

    public void setSettledOrderCount(Integer settledOrderCount) {
        this.settledOrderCount = settledOrderCount;
    }

    public Long getSettledOrderAmt() {
        return settledOrderAmt;
    }

    public void setSettledOrderAmt(Long settledOrderAmt) {
        this.settledOrderAmt = settledOrderAmt;
    }

    public Integer getInviteVIPCountToday() {
        return inviteVIPCountToday;
    }

    public void setInviteVIPCountToday(Integer inviteVIPCountToday) {
        this.inviteVIPCountToday = inviteVIPCountToday;
    }

    public Long getInviteVIPAmtToday() {
        return inviteVIPAmtToday;
    }

    public void setInviteVIPAmtToday(Long inviteVIPAmtToday) {
        this.inviteVIPAmtToday = inviteVIPAmtToday;
    }

    public Integer getShouldSettleInviteCount() {
        return shouldSettleInviteCount;
    }

    public void setShouldSettleInviteCount(Integer shouldSettleInviteCount) {
        this.shouldSettleInviteCount = shouldSettleInviteCount;
    }

    public Long getShouldSettleInviteAmt() {
        return shouldSettleInviteAmt;
    }

    public void setShouldSettleInviteAmt(Long shouldSettleInviteAmt) {
        this.shouldSettleInviteAmt = shouldSettleInviteAmt;
    }

    public Integer getSettledInviteCount() {
        return settledInviteCount;
    }

    public void setSettledInviteCount(Integer settledInviteCount) {
        this.settledInviteCount = settledInviteCount;
    }

    public Long getSettledInviteAmt() {
        return settledInviteAmt;
    }

    public void setSettledInviteAmt(Long settledInviteAmt) {
        this.settledInviteAmt = settledInviteAmt;
    }
}
