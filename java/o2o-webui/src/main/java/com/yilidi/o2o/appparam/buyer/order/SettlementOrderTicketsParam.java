package com.yilidi.o2o.appparam.buyer.order;

import java.util.List;

import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 购物车奖券结算信息接口请求参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SettlementOrderTicketsParam extends TicketItemParam {

    private static final long serialVersionUID = -710875174258537054L;

    @Field("优惠券列表信息")
    private List<TicketItemParam> tickets;

    public void validateParams() {
        if (!ObjectUtils.isNullOrEmpty(tickets)) {
            for (TicketItemParam createOrderTicketItemParam : tickets) {
                createOrderTicketItemParam.validateParams();
            }
        }
    }

    public List<TicketItemParam> getTickets() {
        return tickets;
    }

    public void setTickets(List<TicketItemParam> tickets) {
        this.tickets = tickets;
    }

}
