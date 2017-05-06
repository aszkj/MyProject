package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(调货单验货参数)
 * @author: chenlian
 * @date: 2016年6月23日 上午11:29:46
 */
public class CheckAllotParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String ALLOT_ORDER_NO = "allotOrderNo";

    @Field("调货单编号")
    private String allotOrderNo;

    public void validateParams() {
        Param allotOrderNoValidate = new Param.Builder(getFieldName(ALLOT_ORDER_NO), Param.ParamType.STR_NORMAL.getType(),
                allotOrderNo, false).build();
        ParamValidateUtils.validateParams(allotOrderNoValidate);
    }

    public String getAllotOrderNo() {
        return allotOrderNo;
    }

    public void setAllotOrderNo(String allotOrderNo) {
        this.allotOrderNo = allotOrderNo;
    }

}
