package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 查询专题信息数据参数
 * 
 * @author: chenlian
 * @date: 2016年8月26日 上午10:32:12
 */
public class ThemeInfoParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String TYPE_CODE = "typeCode";

    private static final String STORE_ID = "storeId";

    @Field("专题类型编码")
    private String typeCode;

    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param typeCodeValidate = new Param.Builder(getFieldName(TYPE_CODE), Param.ParamType.STR_NORMAL.getType(), typeCode,
                false).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STORE_ID), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(typeCodeValidate, storeIdValidate);
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
