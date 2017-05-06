package com.yilidi.o2o.core;

public enum SmsTypeModelClassMapping {

    REGISTER("RegisterSmsMessageModel", "注册"), LOGIN("LoginSmsMessageModel", "登录"), RESETPWD("ResetPwdSmsMessageModel",
            "重置密码"), UPDATEPWD("UpdatePwdSmsMessageModel", "修改密码"), USERBINDING("UserBindingSmsMessageModel", "绑定用户"), ORDERCREATE("OrderCreateSmsMessageModel", "订单创建"), ORDERPAID(
            "OrderPaidSmsMessageModel", "订单付款"), ORDERACCEPT("OrderAcceptSmsMessageModel", "订单接单"), ORDERSEND(
            "OrderSendSmsMessageModel", "订单发货"), ORDERPREPARED("OrderPreparedSmsMessageModel", "订单备货"), ORDERREFUND(
            "OrderRefundSmsMessageModel", "订单退款"), ORDERREMINDERPAY("OrderReminderPayMessageModel", "催付款"), ORDERPAYSUCCESS(
            "OrderPaySuccessMessageModel", "付款成功");

    private final String value;
    private final String text;

    private SmsTypeModelClassMapping(String value, String text) {
        this.value = value;
        this.text = text;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    public static SmsTypeModelClassMapping getEnum(String value) {
        if (value != null) {
            SmsTypeModelClassMapping[] values = SmsTypeModelClassMapping.values();
            for (SmsTypeModelClassMapping val : values) {
                if (val.getValue().equals(value)) {
                    return val;
                }
            }
        }
        return null;
    }

}
