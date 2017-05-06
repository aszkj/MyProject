package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 登录
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class LoginParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    // 登录类型正则表达式
    private static final String LOGIN_TYPE_PATTERN = "^(0|1)$";
    @Field("手机号")
    private String mobile;
    private String code;
    @Field("登录类型")
    private Integer type;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName("mobile"), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        String codeMessage = "验证码";
        if (WebConstants.PASSWORD_LOGIN_TYPE == type) {
            codeMessage = "密码";
        }
        Param codeValidate = new Param.Builder(codeMessage, Param.ParamType.STR_NORMAL.getType(), code, false).build();
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(LOGIN_TYPE_PATTERN).build();
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
