package com.yilidi.o2o.appparam.buyer.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 手机验证码校验
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class CheckCaptchaParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    /**
     * 发送验证码类型正则表达式
     */
    private static final String CAPTCHA_TYPE_PATTERN = "^(1|2|3|4)$";

    @Field("手机号")
    private String mobile;
    @Field("验证码")
    private String code;
    @Field("发送验证码类型")
    private Integer type;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName("mobile"), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        Param codeValidate = new Param.Builder(getFieldName("code"), Param.ParamType.STR_NORMAL.getType(), code, false)
                .build();
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(CAPTCHA_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(mobileValidate, typeValidate, codeValidate);
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
