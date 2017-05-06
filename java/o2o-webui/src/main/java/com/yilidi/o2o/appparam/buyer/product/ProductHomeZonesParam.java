package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 首页
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ProductHomeZonesParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("小区ID")
    private Integer communityId;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(communityId) && ObjectUtils.isNullOrEmpty(storeId)) {
            throw new IllegalArgumentException("小区ID和店铺Id不能同时为空");
        }
        Param parentClassCodeValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.STR_INTEGER.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        ParamValidateUtils.validateParams(parentClassCodeValidate, storeIdValidate);
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
