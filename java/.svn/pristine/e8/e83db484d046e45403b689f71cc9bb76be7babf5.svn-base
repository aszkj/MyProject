package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取首页楼层列表参数
 * 
 * @author: chenlian
 * @date: 2016年8月26日 上午11:51:11
 */
public class ProductHomeFloorsParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String COMMUNITY_ID = "communityId";

    private static final String STORE_ID = "storeId";

    @Field("小区ID")
    private Integer communityId;

    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(communityId) && ObjectUtils.isNullOrEmpty(storeId)) {
            throw new IllegalArgumentException("小区ID和店铺Id不能同时为空");
        }
        Param communityIdValidate = new Param.Builder(getFieldName(COMMUNITY_ID), Param.ParamType.STR_INTEGER.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STORE_ID), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        ParamValidateUtils.validateParams(communityIdValidate, storeIdValidate);
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
