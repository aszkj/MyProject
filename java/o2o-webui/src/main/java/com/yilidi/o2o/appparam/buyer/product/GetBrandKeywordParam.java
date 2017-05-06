package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 根据商品条形码获取商品详情数据
 * 
 * @author: xiasl
 * @date: 2016年12月16日19:20:21
 */
public class GetBrandKeywordParam extends PageParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("品牌名称关键字")
    private String keywords;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param brandValidate = new Param.Builder(getFieldName("keywords"), Param.ParamType.STR_NORMAL.getType(), keywords,
                false).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(brandValidate, storeIdValidate);
    }


	public String getKeywords() {
		return keywords;
	}


	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
