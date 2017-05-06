package com.yilidi.o2o.appparam.buyer.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 创建订单
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class CreateOrderParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("备注")
    private String note;

    @Field("优惠券列表信息")
    private List<TicketItemParam> tickets;

    public void validateParams() {
        Param noteValidate = new Param.Builder(getFieldName("note"), Param.ParamType.STR_NORMAL.getType(), note, true)
                .build();
        ParamValidateUtils.validateParams(noteValidate);
        if (!ObjectUtils.isNullOrEmpty(tickets)) {
            for (TicketItemParam ticketItemParam : tickets) {
                ticketItemParam.validateParams();
            }
        }
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<TicketItemParam> getTickets() {
        return tickets;
    }

    public void setTickets(List<TicketItemParam> tickets) {
        this.tickets = tickets;
    }

}
