package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(订单收货参数)
 * @author: chenlian
 * @date: 2016年6月17日 上午10:05:07
 */
public class ReceiveOrderParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String SALE_ORDER_NO = "saleOrderNo";

    private static final String RECEIVE_NO = "receiveNo";

    @Field("订单编号")
    private String saleOrderNo;

    @Field("收货码")
    private String receiveNo;

    public void validateParams() {
        Param saleOrderNoValidate = new Param.Builder(getFieldName(SALE_ORDER_NO), Param.ParamType.STR_NORMAL.getType(),
                saleOrderNo, false).build();
        Param receiveNoValidate = new Param.Builder(getFieldName(RECEIVE_NO), Param.ParamType.STR_NORMAL.getType(),
                receiveNo, false).build();
        ParamValidateUtils.validateParams(saleOrderNoValidate, receiveNoValidate);
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

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}
