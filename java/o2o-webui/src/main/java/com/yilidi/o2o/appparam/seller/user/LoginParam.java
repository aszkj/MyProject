package com.yilidi.o2o.appparam.seller.user;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(登录参数)
 * @author: chenlian
 * @date: 2016年6月11日 下午5:20:17
 */
public class LoginParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String MOBILE = "mobile";

    private static final String TYPE = "type";

    /**
     * 登录类型正则表达式
     */
    private static final String LOGIN_TYPE_PATTERN = "^(0|1)$";

    @Field("手机号")
    private String mobile;

    private String code;

    @Field("登录类型")
    private Integer type;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName(MOBILE), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        Param typeValidate = new Param.Builder(getFieldName(TYPE), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(LOGIN_TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(mobileValidate, typeValidate);
        String codemessage = "验证码";
        if (type.intValue() == WebConstants.PASSWORD_LOGIN_TYPE) {
            codemessage = "密码";
        }
        if (StringUtils.isEmpty(code)) {
            throw new IllegalArgumentException("“" + codemessage + "”" + "不允许为空");
        }
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
