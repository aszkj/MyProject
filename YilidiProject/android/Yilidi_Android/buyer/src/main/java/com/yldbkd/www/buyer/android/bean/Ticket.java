package com.yldbkd.www.buyer.android.bean;

/**
 * 奖券类数据信息
 * <p/>
 * Created by linghuxj on 2016/10/19.
 */

public class Ticket extends BaseModel implements Comparable<Ticket> {

    /**
     * 奖券ID
     */
    private Integer ticketId;
    /**
     * 奖券抢到的数量
     */
    private Integer ticketCount;
    /**
     * 奖券类型：
     * 1：优惠券
     * 2：抵用券
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
    private Long ticketAmount = 0L;
    /**
     * 奖券限制使用金额（满多少金额才能使用）
     */
    private Long limitedAmount = 0L;
    /**
     * 使用范围描述
     */
    private String useScope;
    /**
     * 奖券描述
     */
    private String ticketDescription;
    /**
     * 奖券的状态类型：
     * 0：无效
     * 1：有效
     */
    private Integer ticketStatus;
    /**
     * 奖券的状态类型名称，目前所知有：可领取
     */
    private String ticketStatusName;
    /**
     * 是否选中
     */
    private boolean isCheck = false;

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

    public Integer getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(Integer ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getTicketStatusName() {
        return ticketStatusName;
    }

    public void setTicketStatusName(String ticketStatusName) {
        this.ticketStatusName = ticketStatusName;
    }

    public boolean isCheck() {
        return isCheck;
    }

    public void setCheck(boolean check) {
        isCheck = check;
    }

    @Override
    public int compareTo(Ticket another) {
        if (this.getTicketStatus() > another.getTicketStatus()) {
            return 1;
        } else {
            return -1;
        }
    }
}
