package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 查询专题信息数据接口请求参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SeminarInfoParam extends AppBaseParam {

    private static final long serialVersionUID = 130643113958248313L;
    @Field("店铺ID")
    private Integer storeId;
    @Field("专题编码")
    private String seminarCode;

    public void validateParams() {
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        Param seminarCodeValidate = new Param.Builder(getFieldName("seminarCode"), Param.ParamType.STR_INTEGER.getType(),
                seminarCode, false).build();
        ParamValidateUtils.validateParams(storeIdValidate, seminarCodeValidate);
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
