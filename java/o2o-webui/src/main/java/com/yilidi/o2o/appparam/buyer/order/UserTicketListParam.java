package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 用户券列表
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class UserTicketListParam extends PageParam {

    private static final long serialVersionUID = 4797064397248771965L;
    @Field("券类型")
    private Integer ticketType;

    @Field("券状态")
    private Integer ticketStatus;

    public void validateParams() {
        Param ticketTypeValidate = new Param.Builder(getFieldName("ticketType"), Param.ParamType.STR_INTEGER.getType(),
                ticketType, false).build();
        ParamValidateUtils.validateParams(ticketTypeValidate);
    }

    public Integer getTicketType() {
        return ticketType;
    }

    public void setTicketType(Integer ticketType) {
        this.ticketType = ticketType;
    }

    public Integer getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(Integer ticketStatus) {
        this.ticketStatus = ticketStatus;
    }
}
