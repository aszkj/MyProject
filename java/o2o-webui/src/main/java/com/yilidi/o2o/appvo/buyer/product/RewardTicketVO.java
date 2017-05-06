package com.yilidi.o2o.appvo.buyer.product;

import java.util.Date;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 赠品奖券信息
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class RewardTicketVO extends AppBaseVO {

    private static final long serialVersionUID = -3179403187975945255L;
    /**
     * 奖券ID
     */
    private Integer ticketId;
    /**
     * 奖券类型<br>
     * 1：优惠券 2：抵用券
     */
    private Integer ticketType;
    /**
     * 奖券名称
     */
    private String ticketTypeName;
    /**
     * 奖券金额
     */
    private Long ticketAmount;
    /**
     * 奖励描述
     */
    private String ticketDescription;
    /**
     * 奖励数量
     */
    private Integer cartNum;
    /**
     * 开始时间
     */
    private Date beginTime;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 奖券限制使用金额（满多少金额才能使用)
     */
    private Long limitedAmount;
    /**
     * 使用范围描述
     */
    private String useScope;

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

    public Long getTicketAmount() {
        return ticketAmount;
    }

    public void setTicketAmount(Long ticketAmount) {
        this.ticketAmount = ticketAmount;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
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

}
