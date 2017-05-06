package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 订单支付成功
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class PaySuccessInfoParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("订单编号")
    private String saleOrderNo;

    public void validateParams() {
        Param saleOrderNoValidate = new Param.Builder(getFieldName("saleOrderNo"), Param.ParamType.STR_NORMAL.getType(),
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
