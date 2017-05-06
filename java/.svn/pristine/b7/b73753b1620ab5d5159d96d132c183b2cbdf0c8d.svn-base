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
public class SaveProductFavoriteParam extends AppBaseParam {
    private static final long serialVersionUID = 712823173910867988L;

    @Field("商品ID")
    private Integer productId;

	public void validateParams() {
        Param productIdValidate = new Param.Builder(getFieldName("productId"), Param.ParamType.STR_INTEGER.getType(), productId,
                false).build();
        ParamValidateUtils.validateParams(productIdValidate);
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

}
