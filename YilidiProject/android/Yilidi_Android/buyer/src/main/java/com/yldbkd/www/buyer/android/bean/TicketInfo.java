package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/29 9:56
 * @描述  账本中的优惠券信息
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class TicketInfo extends BaseModel {
    private String ticketTypeName;
    private Integer ticketCount;
    private Integer ticketType;

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
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
}
