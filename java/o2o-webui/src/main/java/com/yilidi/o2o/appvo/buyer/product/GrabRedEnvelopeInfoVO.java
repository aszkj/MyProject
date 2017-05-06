package com.yilidi.o2o.appvo.buyer.product;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 抢红包信息VO
 * 
 * @author: chenlian
 * @date: 2016年11月14日 下午4:01:58
 */
public class GrabRedEnvelopeInfoVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 各类券ID
     */
    private Integer ticketId;

    /**
     * 奖券抢到的数量
     */
    private Integer ticketCount;

    /**
     * 奖券类型
     */
    private Integer ticketType;

    /**
     * 奖券类型名称
     */
    private String ticketTypeName;

    /**
     * 有效期开始时间
     */
    private String beginTime;

    /**
     * 有效期结束时间
     */
    private String endTime;

    /**
     * 奖券金额
     */
    private Long ticketAmount;

    /**
     * 奖券限制使用金额（满多少金额才能使用）
     */
    private Long limitedAmount;

    /**
     * 使用范围描述
     */
    private String useScope;

    /**
     * 奖券描述（关于整张奖券的一些详细描述信息，其中包含了满减金额和使用范围等情况的描述）
     */
    private String ticketDescription;

    /**
     * 奖券的状态类型名称
     */
    private String ticketStatusName;

    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
    }

    public Integer getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(Integer ticketCount) {
        this.ticketCount = ticketCount;
    }

    public Integer getTicketType() {
        return ticketType;
    }

    public void setTicketType(Integer ticketType) {
        this.ticketType = ticketType;
    }

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public Long getTicketAmount() {
        return ticketAmount;
    }

    public void setTicketAmount(Long ticketAmount) {
        this.ticketAmount = ticketAmount;
    }

    public Long getLimitedAmount() {
        return limitedAmount;
    }

    public void setLimitedAmount(Long limitedAmount) {
        this.limitedAmount = limitedAmount;
    }

    public String getUseScope() {
        return useScope;
    }

    public void setUseScope(String useScope) {
        this.useScope = useScope;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }

    public String getTicketStatusName() {
        return ticketStatusName;
    }

    public void setTicketStatusName(String ticketStatusName) {
        this.ticketStatusName = ticketStatusName;
    }

}
