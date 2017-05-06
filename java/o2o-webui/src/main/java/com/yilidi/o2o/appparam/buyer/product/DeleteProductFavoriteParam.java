package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:保存用户收藏商品的参数</p>
 * @author xiasl
 * @date 2017年2月14日
 */
public class DeleteProductFavoriteParam extends AppBaseParam {
    private static final long serialVersionUID = 712823173910867988L;

    @Field("商品ID")
    private String productIds;

	public void validateParams() {
        Param productIdsValidate = new Param.Builder(getFieldName("productIds"), Param.ParamType.STR_NORMAL.getType(), productIds,
                false).build();
        ParamValidateUtils.validateParams(productIdsValidate);
    }

    public String getProductIds() {
        return productIds;
    }

    public void setProductIds(String productIds) {
        this.productIds = productIds;
    }

}
