package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 创建订单
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class TicketItemParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("奖券ID")
    private Integer ticketId;

    @Field("奖券类型")
    private Integer ticketType;

    public void validateParams() {
        Param ticketIdValidate = new Param.Builder(getFieldName("ticketId"), Param.ParamType.INTEGER_TYPE.getType(),
                ticketId, false).build();
        Param ticketTypeValidate = new Param.Builder(getFieldName("ticketType"), Param.ParamType.INTEGER_TYPE.getType(),
                ticketType, false).build();
        ParamValidateUtils.validateParams(ticketIdValidate, ticketTypeValidate);
    }

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
