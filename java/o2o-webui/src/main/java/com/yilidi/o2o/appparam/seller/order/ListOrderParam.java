package com.yilidi.o2o.appparam.seller.order;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(订单列表参数)
 * @author: chenlian
 * @date: 2016年6月16日 上午10:32:58
 */
public class ListOrderParam extends PageParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String STATUS_CODE = "statusCode";

    private static final String KEYWORD = "keyword";

    private static final String ORDERTYPE = "orderType";

    private static final String DELIVERYTYPE = "deliveryType";

    /**
     * 查询订单列表状态类型正则表达式
     */
    private static final String STATUS_CODE_PATTERN = "^(1|2|3|4|5)$";

    /**
     * 订单类型正则表达式
     */
    private static final String ORDER_TYPE_PATTERN = "^(1|2)$";

    /**
     * 配送方式正则表达式
     */
    private static final String DELIVERY_TYPE_PATTERN = "^(1|2)$";

    @Field("订单状态")
    private String statusCode;

    @Field("搜索关键字")
    private String keyword;

    @Field("订单类型")
    private Integer orderType;

    @Field("配送方式")
    private Integer deliveryType;

    public void validateParams() {
        if (StringUtils.isEmpty(statusCode) && StringUtils.isEmpty(keyword)) {
            throw new IllegalArgumentException("订单状态或搜索关键字不能同时为空，至少选择其一");
        }
        if (StringUtils.isEmpty(keyword)) {
            Param statusCodeValidate = new Param.Builder(getFieldName(STATUS_CODE), Param.ParamType.STR_NUMBER.getType(),
                    statusCode, false).regex(STATUS_CODE_PATTERN).build();
            ParamValidateUtils.validateParams(statusCodeValidate);
        }
        if (StringUtils.isEmpty(statusCode)) {
            Param keywordValidate = new Param.Builder(getFieldName(KEYWORD), Param.ParamType.STR_NORMAL.getType(), keyword,
                    false).build();
            ParamValidateUtils.validateParams(keywordValidate);
        }
        Param orderTypeValidate = new Param.Builder(getFieldName(ORDERTYPE), Param.ParamType.INTEGER_TYPE.getType(),
                orderType, true).regex(ORDER_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(orderTypeValidate);
        Param deliveryTypeValidate = new Param.Builder(getFieldName(DELIVERYTYPE), Param.ParamType.INTEGER_TYPE.getType(),
                deliveryType, true).regex(DELIVERY_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(deliveryTypeValidate);
        super.validateParams();
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getOrderType() {
        return orderType;
    }

    public void setOrderType(Integer orderType) {
        this.orderType = orderType;
    }

    public Integer getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(Integer deliveryType) {
        this.deliveryType = deliveryType;
    }

}
