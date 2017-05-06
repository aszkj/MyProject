package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.WebConstants;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 重置密码
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ResetPasswordParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("密码")
    private String password;

    public void validateParams() {
        Param passwordValidate = new Param.Builder(getFieldName("password"), Param.ParamType.STR_NORMAL.getType(), password,
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
