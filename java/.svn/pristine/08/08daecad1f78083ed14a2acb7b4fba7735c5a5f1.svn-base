package com.yilidi.o2o.appparam.seller.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(重置(忘记)密码参数)
 * @author: chenlian
 * @date: 2016年6月12日 下午4:50:25
 */
public class ResetPasswordParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String PASSWORD = "password";

    @Field("密码")
    private String password;

    public void validateParams() {
        Param passwordValidate = new Param.Builder(getFieldName(PASSWORD), Param.ParamType.STR_NORMAL.getType(), password,
                false).regex(WebConstants.PASSWORD_PATTERN).build();
        ParamValidateUtils.validateParams(passwordValidate);
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
