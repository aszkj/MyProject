package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 绑定QQ接收参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class BindQQParam extends AppBaseParam {

    private static final long serialVersionUID = -6925957243821237912L;
    @Field("QQ授权token")
    private String accessToken;
    @Field("openId")
    private String openId;

    public void validateParams() {
        Param accessTokenParam = new Param.Builder(getFieldName("accessToken"), Param.ParamType.STR_NORMAL.getType(),
                accessToken, false).build();
        Param openIdparam = new Param.Builder(getFieldName("openId"), Param.ParamType.STR_NORMAL.getType(), openId, false)
                .build();
        ParamValidateUtils.validateParams(accessTokenParam, openIdparam);
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
