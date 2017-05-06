package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 根据楼层ID查询楼层商品列表参数
 * 
 * @author: chenlian
 * @date: 2016年9月2日 下午17:00:05
 */
public class FloorProductsParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String FLOOR_ID = "floorId";

    private static final String STORE_ID = "storeId";

    @Field("楼层ID")
    private Integer floorId;

    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param floorIdValidate = new Param.Builder(getFieldName(FLOOR_ID), Param.ParamType.STR_INTEGER.getType(), floorId,
                false).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STORE_ID), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(floorIdValidate, storeIdValidate);
    }

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
