package com.yilidi.o2o.appparam.seller.order;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(订单详情参数)
 * @author: chenlian
 * @date: 2016年6月16日 上午10:32:58
 */
public class ShowOrderDetailParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String SALE_ORDER_NO = "saleOrderNo";

    private static final String RECEIVE_NO = "receiveNo";

    @Field("订单编号")
    private String saleOrderNo;

    @Field("收货码")
    private String receiveNo;

    public void validateParams() {
        if (StringUtils.isEmpty(receiveNo) && StringUtils.isEmpty(saleOrderNo)) {
            throw new IllegalArgumentException("订单编号或收货码不能同时为空，至少选择其一");
        }
        if (StringUtils.isEmpty(receiveNo)) {
            Param saleOrderNoValidate = new Param.Builder(getFieldName(SALE_ORDER_NO), Param.ParamType.STR_NORMAL.getType(),
                    saleOrderNo, false).build();
            ParamValidateUtils.validateParams(saleOrderNoValidate);
        }
        if (StringUtils.isEmpty(saleOrderNo)) {
            Param receiveNoValidate = new Param.Builder(getFieldName(RECEIVE_NO), Param.ParamType.STR_NORMAL.getType(),
                    receiveNo, false).build();
            ParamValidateUtils.validateParams(receiveNoValidate);
        }
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getReceiveNo() {
        return receiveNo;
    }

    public void setReceiveNo(String receiveNo) {
        this.receiveNo = receiveNo;
    }

}
