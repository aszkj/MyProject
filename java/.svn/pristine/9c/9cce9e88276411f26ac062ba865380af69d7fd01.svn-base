package com.yilidi.o2o.appparam.seller.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(获取商品类型列表参数)
 * @author: chenlian
 * @date: 2016年6月18日 下午5:30:44
 */
public class GetProductTypeParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String PARENT_CLASS_CODE = "parentClassCode";

    @Field("商品类型")
    private String parentClassCode;

    public void validateParams() {
        Param parentClassCodeValidate = new Param.Builder(getFieldName(PARENT_CLASS_CODE),
                Param.ParamType.STR_NORMAL.getType(), parentClassCode, false).build();
        ParamValidateUtils.validateParams(parentClassCodeValidate);
    }

    public String getParentClassCode() {
        return parentClassCode;
    }

    public void setParentClassCode(String parentClassCode) {
        this.parentClassCode = parentClassCode;
    }

}
