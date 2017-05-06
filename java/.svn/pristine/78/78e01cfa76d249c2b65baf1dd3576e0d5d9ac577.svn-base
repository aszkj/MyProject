package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 微信第三方登录
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class QQLoginParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    @Field("accessToken")
    private String accessToken;
    @Field("openId")
    private String openId;

    public void validateParams() {
        Param accessTokenValidate = new Param.Builder(getFieldName("accessToken"), Param.ParamType.STR_NORMAL.getType(),
                accessToken, false).build();
        Param openIdValidate = new Param.Builder(getFieldName("openId"), Param.ParamType.STR_NORMAL.getType(), openId, false)
                .build();
        ParamValidateUtils.validateParams(accessTokenValidate, openIdValidate);
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

}
