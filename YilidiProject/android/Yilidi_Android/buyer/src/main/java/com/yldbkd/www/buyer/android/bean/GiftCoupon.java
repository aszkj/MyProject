package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 9:56
 * @描述  买赠优惠券信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class GiftCoupon extends BaseModel {
    /**
     * 奖券类型:  1：优惠券 2：抵用券
     */
    private Integer ticketType;
    /**
     * 奖券类型名称
     */
    private String ticketTypeName;
    /**
     * 奖券金额
     */
    private Long ticketAmount;
    /**
     * 奖券赠送的数量
     */
    private Integer cartNum;
    /**
     * 奖券描述
     */
    private String ticketDescription;
    /**
     * 各类券ID
     */
    private Integer ticketId;
    /**
     * 有效期开始时间
     */
    private String beginTime;
    /**
     * 有效期结束时间
     */
    private String endTime;
    /**
     * 奖券限制使用金额
     */
    private Long limitedAmount;
    /**
     * 使用范围描述
     */
    private String useScope;

    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
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

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public String getTicketDescription() {
        return ticketDescription;
    }

    public void setTicketDescription(String ticketDescription) {
        this.ticketDescription = ticketDescription;
    }
}
