package com.yldbkd.www.buyer.android.bean;

/**
 * 购物车的商品和数量信息
 * <p/>
 * Created by linghuxj on 15/11/4.
 */
public class OrderCouponInfo extends BaseModel {

    /**
     * 各类券ID
     */
    private Integer ticketId;
    /**
     * 奖券类型：       1：优惠券      2：抵用券
     */
    private Integer ticketType;

    public Integer getTicketId() {
        return ticketId;
    }

    public void setTicketId(Integer ticketId) {
        this.ticketId = ticketId;
    }

    public Integer getTicketType() {
        return ticketType;
    }

    public void setTicketType(Integer ticketType) {
        this.ticketType = ticketType;
    }
}
