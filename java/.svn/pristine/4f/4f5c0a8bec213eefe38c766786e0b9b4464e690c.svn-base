package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 商品详情
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ProductDetailParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("商品ID")
    private Integer saleProductId;

    public void validateParams() {
        Param parentClassCodeValidate = new Param.Builder(getFieldName("saleProductId"),
                Param.ParamType.STR_INTEGER.getType(), saleProductId, false).build();
        ParamValidateUtils.validateParams(parentClassCodeValidate);
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

}
