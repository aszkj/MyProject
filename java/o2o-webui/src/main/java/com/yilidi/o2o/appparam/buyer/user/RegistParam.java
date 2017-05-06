package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 注册
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class RegistParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    // 登录类型正则表达式
    @Field("手机号")
    private String mobile;
    @Field("验证码")
    private String code;
    @Field("密码")
    private String password;
    @Field("邀请码")
    private String invitationCode;

    public void validateParams() {
        Param mobileValidate = new Param.Builder(getFieldName("mobile"), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        Param codeValidate = new Param.Builder(getFieldName("code"), Param.ParamType.STR_INTEGER.getType(), code, false)
                .build();
        Param passwordValidate = new Param.Builder(getFieldName("password"), Param.ParamType.STR_NORMAL.getType(), code,
                false).regex(WebConstants.PASSWORD_PATTERN).build();
        Param invitationCodeValidate = new Param.Builder(getFieldName("invitationCode"),
                Param.ParamType.STR_NORMAL.getType(), invitationCode, true).build();
        ParamValidateUtils.validateParams(mobileValidate, codeValidate, passwordValidate, invitationCodeValidate);
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

}
