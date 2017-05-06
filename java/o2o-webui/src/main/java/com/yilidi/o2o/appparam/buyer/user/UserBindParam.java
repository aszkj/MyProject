package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 用户绑定
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class UserBindParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    @Field("手机号")
    private String mobile;
    @Field("密码")
    private String password;
    @Field("验证码")
    private String code;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName("mobile"), Param.ParamType.STR_NORMAL.getType(), mobile, false)
                .build();
        Param passwordValidate = new Param.Builder(getFieldName("password"), Param.ParamType.STR_NORMAL.getType(), password,
                false).regex(WebConstants.PASSWORD_PATTERN).build();
        Param codeValidate = new Param.Builder(getFieldName("code"), Param.ParamType.STR_INTEGER.getType(), code, false)
                .build();
        ParamValidateUtils.validateParams(mobileValidate, passwordValidate, codeValidate);
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
