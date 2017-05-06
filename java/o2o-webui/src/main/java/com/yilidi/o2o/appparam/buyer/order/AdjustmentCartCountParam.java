package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 调整购物车数量
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class AdjustmentCartCountParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String TYPE_PATTERN = "^(0|1)$";

    @Field("小区ID")
    private Integer communityId;
    @Field("店铺ID")
    private Integer storeId;
    @Field("商品ID")
    private Integer saleProductId;
    @Field("调整类型")
    private Integer type;
    @Field("活动ID")
    private Integer actId;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(storeId) && ObjectUtils.isNullOrEmpty(communityId)) {
            throw new IllegalArgumentException("小区ID和店铺ID不能同时为空");
        }
        Param communityIdValidate = new Param.Builder(getFieldName("communityId"), Param.ParamType.STR_INTEGER.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        Param saleProductIdValidate = new Param.Builder(getFieldName("saleProductId"), Param.ParamType.STR_INTEGER.getType(),
                saleProductId, false).build();
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(TYPE_PATTERN).build();
        Param actIdValidate = new Param.Builder(getFieldName("actId"), Param.ParamType.STR_INTEGER.getType(), actId, true)
                .build();
        ParamValidateUtils.validateParams(communityIdValidate, storeIdValidate, saleProductIdValidate, typeValidate,
                actIdValidate);
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

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

}
