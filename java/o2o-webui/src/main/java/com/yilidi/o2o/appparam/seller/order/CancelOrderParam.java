package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(订单取消参数)
 * @author: chenlian
 * @date: 2016年6月17日 上午10:01:35
 */
public class CancelOrderParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String SALE_ORDER_NO = "saleOrderNo";

    @Field("订单编号")
    private String saleOrderNo;

    public void validateParams() {
        Param saleOrderNoValidate = new Param.Builder(getFieldName(SALE_ORDER_NO), Param.ParamType.STR_NORMAL.getType(),
                saleOrderNo, false).build();
        ParamValidateUtils.validateParams(saleOrderNoValidate);
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

}
