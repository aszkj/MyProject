package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 同步购物车数量请求参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class AsycnChangeCartParam extends AppBaseParam {

    private static final long serialVersionUID = 5218585952614809607L;
    /**
     * 商品ID
     */
    public static final String SALE_PRODUCT_ID = "saleProductId";
    /**
     * 店铺ID
     */
    public static final String STOREID = "storeId";
    /**
     * 活动ID
     */
    public static final String ACTID = "actId";
    /**
     * 调整类型,0-减少 1-增加
     */
    public static final String TYPE = "type";

    private static final String TYPE_PATTERN = "^(0|1)$";

    @Field("店铺ID")
    private Integer storeId;
    @Field("商品ID")
    private Integer saleProductId;
    @Field("调整类型")
    private Integer type;
    @Field("活动ID")
    private Integer actId;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName(SALE_PRODUCT_ID), Param.ParamType.STR_INTEGER.getType(),
                saleProductId, false).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STOREID), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        Param actIdValidate = new Param.Builder(getFieldName(ACTID), Param.ParamType.STR_INTEGER.getType(), actId, true)
                .build();
        Param typeValidate = new Param.Builder(getFieldName(TYPE), Param.ParamType.STR_INTEGER.getType(), type, false)
                .regex(TYPE_PATTERN).build();
        ParamValidateUtils.validateParams(saleProductIdValidate, storeIdValidate, actIdValidate, typeValidate);
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

}
