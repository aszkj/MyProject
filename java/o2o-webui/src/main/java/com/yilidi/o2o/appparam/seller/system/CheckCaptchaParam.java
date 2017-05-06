package com.yilidi.o2o.appparam.seller.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(手机验证码验证参数)
 * @author: chenlian
 * @date: 2016年6月12日 下午4:21:17
 */
public class CheckCaptchaParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String MOBILE = "mobile";

    private static final String CODE = "code";

    private static final String TYPE = "type";

    /**
     * 发送验证码类型正则表达式
     */
    private static final String CAPTCHA_TYPE_PATTERN = "^(1|2|3)$";

    @Field("手机号")
    private String mobile;

    @Field("验证码")
    private String code;

    @Field("发送验证码类型")
    private Integer type;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName(MOBILE), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        Param codeValidate = new Param.Builder(getFieldName(CODE), Param.ParamType.STR_NUMBER.getType(), code, false)
                .build();
        Param typeValidate = new Param.Builder(getFieldName(TYPE), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(CAPTCHA_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(mobileValidate, codeValidate, typeValidate);
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

}
