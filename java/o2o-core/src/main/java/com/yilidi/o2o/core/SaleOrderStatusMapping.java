package com.yilidi.o2o.core;

import org.apache.commons.lang3.StringUtils;

/**
 * 订单状态枚举
 * 
 * @author: chenb
 * @date: 2016年6月16日 下午9:49:28
 */
public enum SaleOrderStatusMapping {
    /** 待支付 **/
    FORPAY(SystemContext.OrderDomain.SALEORDERSTATUS_FORPAY, 1, "订单已提交"),
    /** 已付款 **/
    PAID(SystemContext.OrderDomain.SALEORDERSTATUS_PAID, 2, "订单支付成功"),
    /** 待发货 **/
    FORSEND(SystemContext.OrderDomain.SALEORDERSTATUS_FORSEND, 3, "已接单"),
    /** 待确认 **/
    FORRECEIVE(SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE, 4, "已发货"),
    /** 已完成 **/
    FINISHED(SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED, 5, "已完成"),
    /** 已评价 **/
    APPRAISE(SystemContext.OrderDomain.SALEORDERSTATUS_APPRAISE, 6, "已评价"),
    /** 已取消 **/
    CANCEL(SystemContext.OrderDomain.SALEORDERSTATUS_CANCEL, 7, "订单取消"),
    /** 退款中 **/
    REFUNDING(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDING, 8, "退款中"),
    /** 退款成功 **/
    REFUNDSUCCESS(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDSUCCESS, 9, "退款成功"),
    /** 退款成功 **/
    REFUNDFAILURE(SystemContext.OrderDomain.SALEORDERSTATUS_REFUNDFAILURE, 10, "退款失败");
    
    private final String code;
    private final Integer type;
    private final String typeName;

    private static final String SALEORDERSTATUS_FORRECEIVE_TYPENAME_PICKUP = "待提货";
    private static final String SALEORDERSTATUS_FINISHED_TYPENAME_PICKUP = "已提货";

    private SaleOrderStatusMapping(String code, Integer type, String typeName) {
        this.code = code;
        this.type = type;
        this.typeName = typeName;
    }

    public String getCode() {
        return code;
    }

    public Integer getType() {
        return type;
    }

    public String getTypeName() {
        return typeName;
    }

    /**
     * 根据后端订单状态code获取订单状态对象F
     * 
     * @param statusCode
     *            订单编码
     * @return SaleOrderStatusMapping
     */
    public static SaleOrderStatusMapping get(String statusCode) {
        if (StringUtils.isEmpty(statusCode)) {
            return null;
        }
        for (SaleOrderStatusMapping saleOrderStatusMapping : SaleOrderStatusMapping.values()) {
            if (saleOrderStatusMapping.getCode().equals(statusCode)) {
                return saleOrderStatusMapping;
            }
        }
        return null;
    }

    /**
     * 根据后端订单状态code获取前端订单状态类型
     * 
     * @param statusCode
     *            订单状态编码
     * @return 订单状态类型
     */
    public static Integer getType(String statusCode) {
        SaleOrderStatusMapping saleOrderStatusMapping = get(statusCode);
        if (null == saleOrderStatusMapping) {
            return null;
        }
        return saleOrderStatusMapping.type;
    }

    /**
     * 根据后端订单状态code获取前端订单状态名称
     * 
     * @param statusCode
     *            订单状态编码
     * @return 订单状态名称
     */
    public static String getTypeName(String statusCode) {
        SaleOrderStatusMapping saleOrderStatusMapping = get(statusCode);
        if (null == saleOrderStatusMapping) {
            return null;
        }
        return saleOrderStatusMapping.typeName;
    }

    /**
     * 根据配送方式获取订单状态名称
     * 
     * @param statusCode
     *            订单状态
     * @param deliveryMode
     *            配送方式
     * @return 订单状态名称
     */
    public static String getTypeName(String statusCode, String deliveryMode) {
        if (StringUtils.isEmpty(deliveryMode)) {
            return getTypeName(statusCode);
        }
        if (SystemContext.OrderDomain.SALEORDERSTATUS_FORRECEIVE.equals(statusCode)
                && SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(deliveryMode)) {
            return SALEORDERSTATUS_FORRECEIVE_TYPENAME_PICKUP;
        }
        if (SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED.equals(statusCode)
                && SystemContext.OrderDomain.SALEORDERDELIVERYMODE_PICKUP.equals(deliveryMode)) {
            return SALEORDERSTATUS_FINISHED_TYPENAME_PICKUP;
        }
        return getTypeName(statusCode);
    }
}
