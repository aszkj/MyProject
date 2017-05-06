package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 奖券账本
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class TicketAccountVO extends AppBaseVO {

    private static final long serialVersionUID = -4894417282718562561L;

    /**
     * 奖券类型名称
     */
    private String ticketTypeName;
    /**
     * 奖券类型总数量
     */
    private Integer ticketCount;
    /**
     * 账本类型值，如：<br>
     * 1：优惠券<br>
     * 2：抵用券<br>
     * 3：实物券（暂时为0）
     */
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
