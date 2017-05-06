package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取小区信息参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class CommunityInfoParam extends AppBaseParam {
    private static final long serialVersionUID = 1L;
    @Field("小区ID")
    private Integer communityId;

    public void validateParams() {
        Param communityIdValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.STR_INTEGER.getType(),
                communityId, false).build();
        ParamValidateUtils.validateParams(communityIdValidate);
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

}
