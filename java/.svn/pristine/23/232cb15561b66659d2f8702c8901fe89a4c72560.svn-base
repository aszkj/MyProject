package com.yilidi.o2o.appparam;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 用户与APP客户端Token关联关系参数
 * 
 * @author: chenlian
 * @date: 2016年8月5日 下午8:04:08
 */
public class UserClientTokenParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String CLIENT_ID = "clientId";
    
    private static final String DEVICE_TOKEN = "deviceToken";

    @Field("APP客户端clientId")
    private String clientId;
    
    @Field("iOS客户端deviceToken")
    private String deviceToken;

    public void validateParams() {
        Param clientIdValidate = new Param.Builder(getFieldName(CLIENT_ID), Param.ParamType.STR_NORMAL.getType(), clientId,
                false).maxLength(128).build();
        Param deviceTokenValidate = new Param.Builder(getFieldName(DEVICE_TOKEN), Param.ParamType.STR_NORMAL.getType(), deviceToken,
                true).maxLength(128).build();
        ParamValidateUtils.validateParams(clientIdValidate,deviceTokenValidate);
    }

    public String getClientId() {
        return clientId;
    }

    public void setClientId(String clientId) {
        this.clientId = clientId;
    }

    public String getDeviceToken() {
        return deviceToken;
    }

    public void setDeviceToken(String deviceToken) {
        this.deviceToken = deviceToken;
    }

}
