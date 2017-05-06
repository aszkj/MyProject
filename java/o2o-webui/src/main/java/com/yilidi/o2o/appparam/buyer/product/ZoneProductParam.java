package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取专区商品
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ZoneProductParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("专区类型")
    private Integer zoneType;
    @Field("小区ID")
    private Integer communityId;
    @Field("storeId")
    private Integer storeId;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(communityId) && ObjectUtils.isNullOrEmpty(storeId)) {
            throw new IllegalArgumentException("小区ID和店铺ID不能同时为空");
        }
        Param zooTypeValidate = new Param.Builder(getFieldName("zoneType"), Param.ParamType.STR_INTEGER.getType(), zoneType,
                false).build();
        Param communityIdValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.INTEGER_TYPE.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.INTEGER_TYPE.getType(), storeId,
                true).build();
        ParamValidateUtils.validateParams(zooTypeValidate, communityIdValidate, storeIdValidate);
    }

    public Integer getZoneType() {
        return zoneType;
    }

    public void setZoneType(Integer zoneType) {
        this.zoneType = zoneType;
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
