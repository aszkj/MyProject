package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取商品分类
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class GetProductTypeParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("商品类型")
    private String parentClassCode;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param parentClassCodeValidate = new Param.Builder(getFieldName("parentClassCode"),
                Param.ParamType.STR_NORMAL.getType(), parentClassCode, false).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(parentClassCodeValidate, storeIdValidate);
    }

    public String getParentClassCode() {
        return parentClassCode;
    }

    public void setParentClassCode(String parentClassCode) {
        this.parentClassCode = parentClassCode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
