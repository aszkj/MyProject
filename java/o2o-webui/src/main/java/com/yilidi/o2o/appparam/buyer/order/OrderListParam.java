package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 订单列表
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class OrderListParam extends PageParam {

    private static final long serialVersionUID = 1L;

    // 登录类型正则表达式
    private static final String STATUSCODE_TYPE_PATTERN = "^(0|1|2|3|4)$";

    @Field("订单列表类型")
    private String statusCode;

    public void validateParams() {
        Param noteValidate = new Param.Builder(getFieldName("statusCode"), Param.ParamType.STR_INTEGER.getType(), statusCode,
                false).regex(STATUSCODE_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(noteValidate);
        super.validateParams();
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

}
