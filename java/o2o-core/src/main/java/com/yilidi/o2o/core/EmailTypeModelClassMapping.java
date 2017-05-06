package com.yilidi.o2o.core;

public enum EmailTypeModelClassMapping {

    REGISTER("RegisterEmailMessageModel", "注册"), LOGIN("LoginEmailMessageModel", "登录");

    private final String value;
    private final String text;

    private EmailTypeModelClassMapping(String value, String text) {
        this.value = value;
        this.text = text;
    }

    public String getValue() {
        return value;
    }

    public String getText() {
        return text;
    }

    public static EmailTypeModelClassMapping getEnum(String value) {
        if (value != null) {
            EmailTypeModelClassMapping[] values = EmailTypeModelClassMapping.values();
            for (EmailTypeModelClassMapping val : values) {
                if (val.getValue().equals(value)) {
                    return val;
                }
            }
        }
        return null;
    }

}
