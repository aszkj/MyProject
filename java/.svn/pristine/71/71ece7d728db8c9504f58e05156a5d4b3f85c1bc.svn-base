package com.yilidi.o2o.appparam.seller.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(修改密码参数)
 * @author: chenlian
 * @date: 2016年6月12日 下午6:14:27
 */
public class UpdatePasswordParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String OLD_PASSWORD = "oldPassword";

    private static final String PASSWORD = "password";

    @Field("原始密码")
    private String oldPassword;

    @Field("新密码")
    private String password;

    public void validateParams() {
        Param oldPasswordValidate = new Param.Builder(getFieldName(OLD_PASSWORD), Param.ParamType.STR_NORMAL.getType(),
                oldPassword, false).regex(WebConstants.PASSWORD_PATTERN).build();
        Param passwordValidate = new Param.Builder(getFieldName(PASSWORD), Param.ParamType.STR_NORMAL.getType(), password,
                false).regex(WebConstants.PASSWORD_PATTERN).build();
        ParamValidateUtils.validateParams(passwordValidate, oldPasswordValidate);
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

}
