package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/22 17:06
 * @描述 订单结算奖券信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */

public class TicketTypes extends BaseModel {
    /**
     * 奖券类型名称
     */
    private String ticketTypeName;
    /**
     * 奖券信息列表
     */
    private List<Ticket> ticketInfoList;
    /**
     * 奖券类型：
     * 1：优惠券
     * 2：抵用券
     */
    private Integer ticketType;

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

    public List<Ticket> getTicketInfoList() {
        return ticketInfoList;
    }

    public void setTicketInfoList(List<Ticket> ticketInfoList) {
        this.ticketInfoList = ticketInfoList;
    }

    public Integer getTicketType() {
        return ticketType;
    }

    public void setTicketType(Integer ticketType) {
        this.ticketType = ticketType;
    }
}
