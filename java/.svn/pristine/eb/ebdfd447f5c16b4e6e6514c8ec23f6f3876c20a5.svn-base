package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取商品品牌
 * 
 * @author: xiasl
 * @date: 2016年12月15日14:37:35
 */
public class GetBrandTypeParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("是否热门")
    private String type;
    @Field("店铺ID")
    private Integer storeId;

	public void validateParams() {
        Param typeValidate = new Param.Builder(getFieldName("type"),
                Param.ParamType.STR_NORMAL.getType(), type, false).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        ParamValidateUtils.validateParams(typeValidate,storeIdValidate);
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}


}
