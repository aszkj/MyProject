package com.yilidi.o2o.appparam.seller.product;

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
    
    private static final String ENABLED_FLAG = "enabledFlag";
    /**
     * 上下架操作类型正则表达式
     */
    private static final String ENABLED_FLAG_PATTERN = "^(0|1|2)$";
    @Field("品牌编码")
    private String brandCode;
    @Field("上下架标识")
    private Integer enabledFlag;

    public void validateParams() {
        Param brandValidate = new Param.Builder(getFieldName("brandCode"), Param.ParamType.STR_NORMAL.getType(), brandCode,
                false).build();
        Param enabledFlagValidate = new Param.Builder(getFieldName(ENABLED_FLAG), Param.ParamType.STR_INTEGER.getType(),
                enabledFlag, true).regex(ENABLED_FLAG_PATTERN).build();
        ParamValidateUtils.validateParams(brandValidate,enabledFlagValidate);
    }

    public Integer getEnabledFlag() {
		return enabledFlag;
	}

	public void setEnabledFlag(Integer enabledFlag) {
		this.enabledFlag = enabledFlag;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

}
