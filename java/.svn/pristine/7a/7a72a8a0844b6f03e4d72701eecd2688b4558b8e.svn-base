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
public class ProductByBrandCodeParam extends PageParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("品牌编码")
    private String brandCode;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param brandValidate = new Param.Builder(getFieldName("brandCode"), Param.ParamType.STR_NORMAL.getType(), brandCode,
                false).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(brandValidate, storeIdValidate);
    }

    public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
