package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 修改用户头像地址接口
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class UpdateAvatarParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    @Field("头像地址")
    private String userImageUrl;

    public void validateParams() {
        Param userImageUrlValidate = new Param.Builder(getFieldName("userImageUrl"), Param.ParamType.STR_NORMAL.getType(),
                userImageUrl, false).build();
        ParamValidateUtils.validateParams(userImageUrlValidate);
    }

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

}
