package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:获取用户收藏商品的参数</p>
 * @author xiasl
 * @date 2017年2月14日
 */
public class GetProductFavoriteParam extends PageParam {

    private static final long serialVersionUID = 2636972919805833648L;
    @Field("店铺ID")
    private Integer storeId;

	public void validateParams() {
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(storeIdValidate);
    }

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

}
