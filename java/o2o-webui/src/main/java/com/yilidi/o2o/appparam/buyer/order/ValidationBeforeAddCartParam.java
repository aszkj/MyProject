package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 加入购物车信息前校验
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ValidationBeforeAddCartParam extends AppBaseParam {
    private static final long serialVersionUID = 395238208817318273L;
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

    @Field("商品ID")
    private Integer saleProductId;

    @Field("店铺ID")
    private Integer storeId;
    @Field("活动ID")
    private Integer actId;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName(SALE_PRODUCT_ID), Param.ParamType.STR_INTEGER.getType(),
                saleProductId, false).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STOREID), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        Param actIdValidate = new Param.Builder(getFieldName(ACTID), Param.ParamType.STR_INTEGER.getType(), actId, true)
                .build();
        ParamValidateUtils.validateParams(saleProductIdValidate, storeIdValidate, actIdValidate);
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

}
