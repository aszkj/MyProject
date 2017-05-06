package com.yilidi.o2o.core;

public enum PushTypeModelClassMapping {

    ORDERACCEPT("OrderAcceptPushMessageModel", "订单接单");

    private final String value;
    private final String text;

    private PushTypeModelClassMapping(String value, String text) {
        this.value = value;
        this.text = text;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    public static PushTypeModelClassMapping getEnum(String value) {
        if (value != null) {
            PushTypeModelClassMapping[] values = PushTypeModelClassMapping.values();
            for (PushTypeModelClassMapping val : values) {
                if (val.getValue().equals(value)) {
                    return val;
                }
            }
        }
        return null;
    }

}
